/******************************************************************************
* Web Server Header File
* 
* Implements a simple HTTP web server with two threads:
* - Reception thread: receives HTTP requests
* - Transmission thread: sends HTTP responses
******************************************************************************/

#ifndef WEB_SERVER_H
#define WEB_SERVER_H

#include "includes.h"
#include "ipport.h"
#include "tcpport.h"
#include "system.h"
#include <io.h>

/* Web server port */
#define WEB_SERVER_PORT 80

/* Maximum string length */
#define MAX_STRING_LENGTH 100

/* User_HW base address (to be configured in system.h) */
#ifndef USER_HW_BASE
#define USER_HW_BASE 0x00000000  // Update with actual base address
#endif

/* User_HW register offsets */
#define USER_HW_DATA_IN    0x00
#define USER_HW_DATA_OUT   0x04
#define USER_HW_CONTROL    0x08
#define USER_HW_LENGTH     0x0C

/* User_HW control bits */
#define USER_HW_START_PROC 0x01
#define USER_HW_DONE       0x02
#define USER_HW_PROCESSING 0x04

/* Connection structure */
typedef struct {
    int fd;
    int state;
    char rx_buffer[1024];
    char tx_buffer[1024];
    int rx_len;
    int tx_len;
} WebConn;

/* Connection states */
#define CONN_READY    0
#define CONN_RECEIVING 1
#define CONN_PROCESSING 2
#define CONN_SENDING   3
#define CONN_CLOSE     4

/* Task priorities */
#define WEB_RX_TASK_PRIORITY  5
#define WEB_TX_TASK_PRIORITY  6

/* Function prototypes */
void WebServerInit(void);
void WebServerRxTask(void);
void WebServerTxTask(void);
int ProcessHTTPRequest(WebConn* conn);
void SendHTTPResponse(WebConn* conn, const char* response_data);
int ProcessStringWithUserHW(const char* input, char* output, int length);

#endif /* WEB_SERVER_H */

