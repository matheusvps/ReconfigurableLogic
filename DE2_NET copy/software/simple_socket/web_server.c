/******************************************************************************
* Web Server Implementation
* 
* Implements a simple HTTP web server with two threads:
* - Reception thread: receives HTTP requests
* - Transmission thread: sends HTTP responses
******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "web_server.h"
#include "alt_error_handler.h"
#include "basic_io.h"
#include <io.h>

/* Global connection structure */
static WebConn web_conn;
static OS_EVENT *web_rx_sem;
static OS_EVENT *web_tx_sem;
static OS_EVENT *web_mutex;

/* Task stacks */
OS_STK WebRxTaskStk[TASK_STACKSIZE];
OS_STK WebTxTaskStk[TASK_STACKSIZE];

/* TK_NEWTASK declarations for NicheStack tasks */
TK_OBJECT(to_web_rx_task);
TK_OBJECT(to_web_tx_task);
TK_ENTRY(WebServerRxTask);
TK_ENTRY(WebServerTxTask);

struct inet_taskinfo web_rx_task = {
    &to_web_rx_task,
    "web rx task",
    WebServerRxTask,
    WEB_RX_TASK_PRIORITY,
    APP_STACK_SIZE,
};

struct inet_taskinfo web_tx_task = {
    &to_web_tx_task,
    "web tx task",
    WebServerTxTask,
    WEB_TX_TASK_PRIORITY,
    APP_STACK_SIZE,
};

/* Initialize web server */
void WebServerInit(void)
{
    INT8U error_code;
    
    /* Initialize connection */
    memset(&web_conn, 0, sizeof(WebConn));
    web_conn.fd = -1;
    web_conn.state = CONN_READY;
    
    /* Create semaphores and mutex */
    web_rx_sem = OSSemCreate(0);
    web_tx_sem = OSSemCreate(0);
    web_mutex = OSSemCreate(1);
    
    if (!web_rx_sem || !web_tx_sem || !web_mutex) {
        alt_uCOSIIErrorHandler(EXPANDED_DIAGNOSIS_CODE,
                              "Failed to create web server semaphores");
    }
    
    /* Create tasks */
    TK_NEWTASK(&web_rx_task);
    TK_NEWTASK(&web_tx_task);
    
    printf("[WebServer] Initialized\n");
}

/* Process string with User_HW */
int ProcessStringWithUserHW(const char* input, char* output, int length)
{
    int i;
    alt_u32 status_val;
    alt_u32 char_val;
    
    if (length > MAX_STRING_LENGTH) {
        length = MAX_STRING_LENGTH;
    }
    
    if (length <= 0) {
        return 0;
    }
    
    /* Write length to User_HW first (this resets write index) */
    IOWR_32DIRECT(USER_HW_BASE, USER_HW_LENGTH, length);
    TK_SLEEP(1);
    
    /* Write input string to User_HW character by character */
    for (i = 0; i < length; i++) {
        IOWR_32DIRECT(USER_HW_BASE, USER_HW_DATA_IN, (alt_u32)input[i]);
        TK_SLEEP(1);  /* Small delay between writes */
    }
    
    /* Start processing */
    IOWR_32DIRECT(USER_HW_BASE, USER_HW_CONTROL, USER_HW_START_PROC);
    
    /* Wait for processing to complete */
    do {
        status_val = IORD_32DIRECT(USER_HW_BASE, USER_HW_CONTROL);
        TK_SLEEP(1);  /* Yield to other tasks */
    } while ((status_val & USER_HW_DONE) == 0);
    
    /* Reset read index */
    IOWR_32DIRECT(USER_HW_BASE, USER_HW_DATA_OUT, 0);
    TK_SLEEP(1);
    
    /* Read processed string from User_HW */
    for (i = 0; i < length; i++) {
        char_val = IORD_32DIRECT(USER_HW_BASE, USER_HW_DATA_OUT);
        output[i] = (char)(char_val & 0xFF);
        TK_SLEEP(1);  /* Small delay between reads */
    }
    
    /* Clear start bit */
    IOWR_32DIRECT(USER_HW_BASE, USER_HW_CONTROL, 0);
    
    output[length] = '\0';
    return length;
}

/* Process HTTP request */
int ProcessHTTPRequest(WebConn* conn)
{
    char* method;
    char* path;
    char* body_start;
    char input_string[MAX_STRING_LENGTH + 1];
    char output_string[MAX_STRING_LENGTH + 1];
    int string_length = 0;
    
    /* Find HTTP method */
    method = strstr(conn->rx_buffer, "POST");
    if (!method) {
        method = strstr(conn->rx_buffer, "GET");
    }
    
    if (!method) {
        return -1;
    }
    
    /* Handle GET request - return HTML form */
    if (strncmp(method, "GET", 3) == 0) {
        return 0;  /* Will send HTML form */
    }
    
    /* Handle POST request - process string */
    if (strncmp(method, "POST", 4) == 0) {
        /* Find body start */
        body_start = strstr(conn->rx_buffer, "\r\n\r\n");
        if (body_start) {
            body_start += 4;  /* Skip \r\n\r\n */
            
            /* Extract string from POST data (format: string=...&...) */
            char* string_param = strstr(body_start, "string=");
            if (string_param) {
                string_param += 7;  /* Skip "string=" */
                
                /* Extract string (up to MAX_STRING_LENGTH) */
                int i = 0;
                while (i < MAX_STRING_LENGTH && string_param[i] != '\0' && 
                       string_param[i] != '&' && string_param[i] != '\r' && 
                       string_param[i] != '\n') {
                    input_string[i] = string_param[i];
                    i++;
                }
                string_length = i;
                input_string[string_length] = '\0';
                
                /* Process string with User_HW */
                if (string_length > 0) {
                    ProcessStringWithUserHW(input_string, output_string, string_length);
                    
                    /* Store result in connection for transmission */
                    snprintf(conn->tx_buffer, sizeof(conn->tx_buffer),
                            "HTTP/1.1 200 OK\r\n"
                            "Content-Type: text/html\r\n"
                            "Connection: close\r\n"
                            "\r\n"
                            "<!DOCTYPE html>\r\n"
                            "<html><head><title>String Processor</title></head>\r\n"
                            "<body>\r\n"
                            "<h1>String Processor Result</h1>\r\n"
                            "<p><strong>Input:</strong> %s</p>\r\n"
                            "<p><strong>Output:</strong> %s</p>\r\n"
                            "<form method=\"POST\">\r\n"
                            "<input type=\"text\" name=\"string\" maxlength=\"100\" size=\"50\">\r\n"
                            "<input type=\"submit\" value=\"Process\">\r\n"
                            "</form>\r\n"
                            "</body></html>\r\n",
                            input_string, output_string);
                    conn->tx_len = strlen(conn->tx_buffer);
                    return 1;  /* Ready to send */
                }
            }
        }
    }
    
    return -1;
}

/* Send HTTP response */
void SendHTTPResponse(WebConn* conn, const char* response_data)
{
    if (response_data) {
        strncpy(conn->tx_buffer, response_data, sizeof(conn->tx_buffer) - 1);
        conn->tx_buffer[sizeof(conn->tx_buffer) - 1] = '\0';
        conn->tx_len = strlen(conn->tx_buffer);
    } else {
        /* Default HTML form */
        snprintf(conn->tx_buffer, sizeof(conn->tx_buffer),
                "HTTP/1.1 200 OK\r\n"
                "Content-Type: text/html\r\n"
                "Connection: close\r\n"
                "\r\n"
                "<!DOCTYPE html>\r\n"
                "<html><head><title>String Processor</title></head>\r\n"
                "<body>\r\n"
                "<h1>String Processor</h1>\r\n"
                "<p>Enter a string (max 100 characters) to process:</p>\r\n"
                "<form method=\"POST\">\r\n"
                "<input type=\"text\" name=\"string\" maxlength=\"100\" size=\"50\">\r\n"
                "<input type=\"submit\" value=\"Process\">\r\n"
                "</form>\r\n"
                "</body></html>\r\n");
        conn->tx_len = strlen(conn->tx_buffer);
    }
}

/* Reception thread */
void WebServerRxTask(void)
{
    int fd_listen;
    struct sockaddr_in addr;
    fd_set readfds;
    int max_socket;
    int rx_code;
    
    printf("[WebServerRx] Starting reception thread\n");
    
    /* Create listening socket */
    if ((fd_listen = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,
                                "[WebServerRx] Socket creation failed");
        return;
    }
    
    /* Bind socket */
    addr.sin_family = AF_INET;
    addr.sin_port = htons(WEB_SERVER_PORT);
    addr.sin_addr.s_addr = INADDR_ANY;
    
    if (bind(fd_listen, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,
                                "[WebServerRx] Bind failed");
        close(fd_listen);
        return;
    }
    
    /* Listen */
    if (listen(fd_listen, 1) < 0) {
        alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,
                                "[WebServerRx] Listen failed");
        close(fd_listen);
        return;
    }
    
    printf("[WebServerRx] Listening on port %d\n", WEB_SERVER_PORT);
    
    while (1) {
        /* Wait for mutex */
        OSSemPend(web_mutex, 0, NULL);
        
        /* Check if connection is ready */
        if (web_conn.fd == -1) {
            /* Setup select for listening socket */
            FD_ZERO(&readfds);
            FD_SET(fd_listen, &readfds);
            max_socket = fd_listen + 1;
            
            OSSemPost(web_mutex);
            
            select(max_socket, &readfds, NULL, NULL, NULL);
            
            if (FD_ISSET(fd_listen, &readfds)) {
                /* Accept connection */
                int len = sizeof(addr);
                int new_fd = accept(fd_listen, (struct sockaddr *)&addr, &len);
                
                if (new_fd >= 0) {
                    OSSemPend(web_mutex, 0, NULL);
                    web_conn.fd = new_fd;
                    web_conn.state = CONN_RECEIVING;
                    web_conn.rx_len = 0;
                    memset(web_conn.rx_buffer, 0, sizeof(web_conn.rx_buffer));
                    OSSemPost(web_mutex);
                    
                    printf("[WebServerRx] Accepted connection from %s\n",
                           inet_ntoa(addr.sin_addr));
                }
            }
        } else {
            /* Setup select for data socket */
            FD_ZERO(&readfds);
            FD_SET(web_conn.fd, &readfds);
            max_socket = web_conn.fd + 1;
            
            OSSemPost(web_mutex);
            
            select(max_socket, &readfds, NULL, NULL, NULL);
            
            if (FD_ISSET(web_conn.fd, &readfds)) {
                OSSemPend(web_mutex, 0, NULL);
                
                if (web_conn.state == CONN_RECEIVING) {
                    /* Receive data */
                    rx_code = recv(web_conn.fd, 
                                   web_conn.rx_buffer + web_conn.rx_len,
                                   sizeof(web_conn.rx_buffer) - web_conn.rx_len - 1,
                                   0);
                    
                    if (rx_code > 0) {
                        web_conn.rx_len += rx_code;
                        web_conn.rx_buffer[web_conn.rx_len] = '\0';
                        
                        /* Check if we have complete HTTP request */
                        if (strstr(web_conn.rx_buffer, "\r\n\r\n")) {
                            /* Process request */
                            int result = ProcessHTTPRequest(&web_conn);
                            
                            if (result >= 0) {
                                web_conn.state = CONN_PROCESSING;
                                if (result == 0) {
                                    /* Send HTML form */
                                    SendHTTPResponse(&web_conn, NULL);
                                }
                                web_conn.state = CONN_SENDING;
                                OSSemPost(web_tx_sem);  /* Signal TX thread */
                            } else {
                                web_conn.state = CONN_CLOSE;
                            }
                        }
                    } else if (rx_code <= 0) {
                        /* Connection closed or error */
                        web_conn.state = CONN_CLOSE;
                    }
                }
                
                OSSemPost(web_mutex);
            }
        }
    }
}

/* Transmission thread */
void WebServerTxTask(void)
{
    int tx_code;
    
    printf("[WebServerTx] Starting transmission thread\n");
    
    while (1) {
        /* Wait for transmission semaphore */
        OSSemPend(web_tx_sem, 0, NULL);
        
        OSSemPend(web_mutex, 0, NULL);
        
        if (web_conn.state == CONN_SENDING && web_conn.fd >= 0) {
            /* Send response */
            tx_code = send(web_conn.fd, web_conn.tx_buffer, web_conn.tx_len, 0);
            
            if (tx_code > 0) {
                printf("[WebServerTx] Sent %d bytes\n", tx_code);
            }
            
            /* Close connection */
            close(web_conn.fd);
            web_conn.fd = -1;
            web_conn.state = CONN_READY;
        }
        
        OSSemPost(web_mutex);
    }
}

