/******************************************************************************
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
* All rights reserved. All use of this software and documentation is          *
* subject to the License Agreement located at the end of this file below.     *
*******************************************************************************
* Date - October 24, 2006                                                     *
* Module - simple_socket_server.c                                             *
*                                                                             *
******************************************************************************/
 
/******************************************************************************
 * Simple Socket Server (SSS) example. 
 * 
 * This example demonstrates the use of MicroC/OS-II running on NIOS II.       
 * In addition it is to serve as a good starting point for designs using       
 * MicroC/OS-II and Altera NicheStack TCP/IP Stack - NIOS II Edition.                                          
 *                                                                             
 * -Known Issues                                                             
 *     None.   
 *      
 * Please refer to the Altera NicheStack Tutorial documentation for details on this 
 * software example, as well as details on how to configure the NicheStack TCP/IP 
 * networking stack and MicroC/OS-II Real-Time Operating System.  
 */
 
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

/* MicroC/OS-II definitions */
#include "includes.h"

/* Simple Socket Server definitions */
#include "simple_socket_server.h"                                                                    
#include "alt_error_handler.h"

/* Nichestack definitions */
#include "ipport.h"
#include "tcpport.h"
#include <io.h>
#include <fcntl.h>
//#include "BASICTYP.h"
#include "system.h"
#include "basic_io.h"
#include <sys/socket.h>

#define IPPROTO_TCP 6

/* Function prototypes */
void SSSRXTask(void);
void SSSTXTask(void);

/*
 * Global handles (pointers) to our MicroC/OS-II resources. All of resources 
 * beginning with "SSS" are declared and created in this file.
 */

/*
 * This SSSLEDCommandQ MicroC/OS-II message queue will be used to communicate 
 * between the simple socket server task and Nios Development Board LED control 
 * tasks.
 *
 * Handle to our MicroC/OS-II Command Queue and variable definitions related to 
 * the Q for sending commands received on the TCP-IP socket from the 
 * SSSSimpleSocketServerTask to the LEDManagementTask.
 */
OS_EVENT  *SSSLEDCommandQ;
#define SSS_LED_COMMAND_Q_SIZE  30  /* Message capacity of SSSLEDCommandQ */
void *SSSLEDCommandQTbl[SSS_LED_COMMAND_Q_SIZE]; /*Storage for SSSLEDCommandQ*/


/*
 * Handle to our MicroC/OS-II LED Event Flag.  Each flag corresponds to one of
 * the LEDs on the Nios Development board, D0 - D7. 
 */
OS_FLAG_GRP *SSSLEDEventFlag;

/*
 * Handle to our MicroC/OS-II LED Lightshow Semaphore. The semaphore is checked 
 * by the LED7SegLightshowTask each time it updates 7 segment LED displays, 
 * U8 and U9.  The LEDManagementTask grabs the semaphore away from the lightshow task to
 * toggle the lightshow off, and gives up the semaphore to turn the lightshow
 * back on.  The LEDManagementTask does this in response to the CMD_LEDS_LIGHTSHOW
 * command sent from the SSSSimpleSocketServerTask when the user sends a toggle 
 * lightshow command over the TCPIP socket.
 */
OS_EVENT *SSSLEDLightshowSem;

/* Definition of Task Stacks for tasks not invoked by TK_NEWTASK 
 * (do not use NicheStack) 
 */

OS_STK    LEDManagementTaskStk[TASK_STACKSIZE];
OS_STK    LED7SegLightshowTaskStk[TASK_STACKSIZE];
OS_STK    SSSRXTaskStk[TASK_STACKSIZE];
OS_STK    SSSTXTaskStk[TASK_STACKSIZE];

/* Global connection structure shared between RX and TX tasks */
static SSSConn g_conn;
OS_EVENT *g_conn_sem;  /* Semaphore for connection synchronization */

/*
 * Create our MicroC/OS-II resources. All of the resources beginning with
 * "SSS" are declared in this file, and created in this function.
 */
void SSSCreateOSDataStructs(void)
{
  INT8U error_code;
  
  /*
  * Create the resource for our MicroC/OS-II Queue for sending commands 
  * received on the TCP/IP socket from the SSSSimpleSocketServerTask()
  * to the LEDManagementTask().
  */
  SSSLEDCommandQ = OSQCreate(&SSSLEDCommandQTbl[0], SSS_LED_COMMAND_Q_SIZE);
  if (!SSSLEDCommandQ)
  {
     alt_uCOSIIErrorHandler(EXPANDED_DIAGNOSIS_CODE, 
     "Failed to create SSSLEDCommandQ.\n");
  }
  
 /* Create our MicroC/OS-II LED Lightshow Semaphore.  The semaphore is checked 
  * by the SSSLEDLightshowTask each time it updates 7 segment LED displays, 
  * U8 and U9.  The LEDTask grabs the semaphore away from the lightshow task to
  * toggle the lightshow off, and gives up the semaphore to turn the lightshow
  * back on.  The LEDTask does this in response to the CMD_LEDS_LIGHTSHOW
  * command sent from the SSSSimpleSocketServerTask when the user sends the 
  * toggle lightshow command over the TCPIP socket.
  */
  SSSLEDLightshowSem = OSSemCreate(1);
  if (!SSSLEDLightshowSem)
  {
     alt_uCOSIIErrorHandler(EXPANDED_DIAGNOSIS_CODE, 
                            "Failed to create SSSLEDLightshowSem.\n");
  }
  
 /*
  * Create our MicroC/OS-II LED Event Flag.  Each flag corresponds to one of
  * the LEDs on the Nios Development board, D0 - D7.
  */
  SSSLEDEventFlag = OSFlagCreate(0, &error_code);
  if (!SSSLEDEventFlag)
  {
     alt_uCOSIIErrorHandler(error_code, 0);
  }

  /* Create semaphore for connection synchronization between RX and TX tasks */
  g_conn_sem = OSSemCreate(1);
  if (!g_conn_sem)
  {
     alt_uCOSIIErrorHandler(EXPANDED_DIAGNOSIS_CODE,
                            "Failed to create g_conn_sem.\n");
  }

  /* Initialize global connection structure */
  sss_reset_connection(&g_conn);
}

/* This function creates tasks used in this example which do not use sockets.
 * Tasks which use Interniche sockets must be created with TK_NEWTASK.
 */
 
void SSSCreateTasks(void)
{
   INT8U error_code;

   // RX and TX tasks are now created with TK_NEWTASK in iniche_init.c

   error_code = OSTaskCreateExt(LED7SegLightshowTask,
                             NULL,
                             (void *)&LED7SegLightshowTaskStk[TASK_STACKSIZE-1],
                             LED_7SEG_LIGHTSHOW_TASK_PRIORITY,
                             LED_7SEG_LIGHTSHOW_TASK_PRIORITY,
                             LED7SegLightshowTaskStk,
                             TASK_STACKSIZE,
                             NULL,
                             0);

   alt_uCOSIIErrorHandler(error_code, 0);

   error_code = OSTaskCreateExt(LEDManagementTask,
                              NULL,
                              (void *)&LEDManagementTaskStk[TASK_STACKSIZE-1],
                              LED_MANAGEMENT_TASK_PRIORITY,
                              LED_MANAGEMENT_TASK_PRIORITY,
                              LEDManagementTaskStk,
                              TASK_STACKSIZE,
                              NULL,
                              0);

   alt_uCOSIIErrorHandler(error_code, 0);

}


/*
 * sss_reset_connection()
 * 
 * This routine will, when called, reset our SSSConn struct's members 
 * to a reliable initial state. Note that we set our socket (FD) number to
 * -1 to easily determine whether the connection is in a "reset, ready to go" 
 * state.
 */
void sss_reset_connection(SSSConn* conn)
{
  memset(conn, 0, sizeof(SSSConn));

  conn->fd = -1;
  conn->state = READY;
  conn->rx_wr_pos = conn->rx_buffer;
  conn->rx_rd_pos = conn->rx_buffer;
  return;
}

/*
 * sss_send_simple_response()
 * 
 * This routine will transmit simple response out to the telnet client.
 */
void sss_send_simple_response(SSSConn* conn)
{
  alt_u8  tx_buf[SSS_TX_BUF_SIZE];
  alt_u8 *tx_wr_pos = tx_buf;

  const char *response_body = "<html><body><h1>Welcome to NIOS II Server</h1></body></html>";
  int content_length = strlen(response_body);

  tx_wr_pos += sprintf((char*)tx_wr_pos,
	"HTTP/1.1 200 OK\r\n"
	"Content-Type: text/html\r\n"
	"Content-Length: %d\r\n"
	"Access-Control-Allow-Origin: *\r\n"
	"Access-Control-Allow-Methods: POST, GET, OPTIONS\r\n"
	"Access-Control-Allow-Headers: Content-Type\r\n"
	"\r\n"
	"%s", content_length, response_body
);

  send(conn->fd, (char*)tx_buf, tx_wr_pos - tx_buf, 0);
  
  return;
}

/*
 * sss_handle_accept()
 * 
 * This routine is called when ever our listening socket has an incoming
 * connection request. Since this example has only data transfer socket, 
 * we just look at it to see whether its in use... if so, we accept the 
 * connection request and call the telent_send_menu() routine to transmit
 * instructions to the user. Otherwise, the connection is already in use; 
 * reject the incoming request by immediately closing the new socket.
 * 
 * We'll also print out the client's IP address.
 */
void sss_handle_accept(int listen_socket, SSSConn* conn)
{
  int                 socket, len;
  struct sockaddr_in  incoming_addr;

  len = sizeof(incoming_addr);

  if ((conn)->fd == -1)
  {
     if((socket=accept(listen_socket,(struct sockaddr*)&incoming_addr,&len))<0)
     {
         alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,
                                 "[sss_handle_accept] accept failed");
     }
     else
     {
        (conn)->fd = socket;
        // sss_send_simple_response(conn);
        printf("[sss_handle_accept] accepted connection request from %s\n",
               inet_ntoa(incoming_addr.sin_addr));
     }
  }
  else
  {
    printf("[sss_handle_accept] rejected connection request from %s\n",
           inet_ntoa(incoming_addr.sin_addr));
  }

  return;
}

/*
 * sss_exec_command()
 * 
 * This routine is called whenever we have new, valid receive data from our 
 * sss connection. It will parse through the data simply looking for valid
 * commands to the sss server.
 * 
 * Incoming commands to talk to the board LEDs are handled by sending the 
 * MicroC/OS-II SSSLedCommandQ a pointer to the value we received.
 * 
 * If the user wishes to quit, we set the "close" member of our SSSConn
 * struct, which will be looked at back in sss_handle_receive() when it 
 * comes time to see whether to close the connection or not.
 */
void sss_exec_command(SSSConn* conn)
{
   int bytes_to_process = conn->rx_wr_pos - conn->rx_rd_pos;
   INT8U tx_buf[SSS_TX_BUF_SIZE];
   INT8U *tx_wr_pos = tx_buf;
   char *body_start = NULL;
   char *content_length_str = NULL;
   int content_length = 0;
   char *data_start = NULL;
   int i;

   printf("[sss_exec_command] executing command on RX data\n");

   /* OPTIONS handling (CORS) */
   if (strstr((char*)conn->rx_buffer, "OPTIONS") == conn->rx_buffer) {
       tx_wr_pos += sprintf((char*)tx_wr_pos,
           "HTTP/1.1 204 No Content\r\n"
           "Access-Control-Allow-Origin: *\r\n"
           "Access-Control-Allow-Methods: POST, GET, OPTIONS\r\n"
           "Access-Control-Allow-Headers: Content-Type\r\n"
           "Content-Length: 0\r\n"
           "\r\n"
       );
       send(conn->fd, (char*)tx_buf, tx_wr_pos - tx_buf, 0);
       conn->close = 1;
       return;
   }

   /* POST /process */
   if (strstr((char*)conn->rx_buffer, "POST /process") != NULL) {
      printf("[sss_exec_command] processing POST /process request\n");

      /* Encontrar Content-Length */
      content_length_str = strstr((char*)conn->rx_buffer, "Content-Length:");
      if (content_length_str) {
         content_length = atoi(content_length_str + 15);
      }

      /* Encontrar início do body */
      body_start = strstr((char*)conn->rx_buffer, "\r\n\r\n");
      if (body_start) {
         printf("[sss_exec_command] found body with length %d\n", content_length);
         body_start += 4;
         data_start = body_start;

         /* Buffer de saída (bytes single-byte Latin-1) */
         unsigned char out_buf[SSS_TX_BUF_SIZE];
         int in_idx = 0;
         int out_len = 0;

         unsigned char *in = (unsigned char*)data_start;

         while (in_idx < content_length && out_len < (int)sizeof(out_buf)) {
             unsigned int b = in[in_idx];

             /* Detecta sequência UTF-8 de 2 bytes para U+00XX (0xC2/0xC3 ...) */
             if ((b == 0xC2 || b == 0xC3) && (in_idx + 1 < content_length)) {
                 unsigned int b2 = in[in_idx + 1];
                 if ((b2 & 0xC0) == 0x80) {
                     unsigned int codepoint = ((b & 0x1F) << 6) | (b2 & 0x3F); /* U+00XX */
                     unsigned char mapped = (unsigned char)(codepoint & 0xFF);
                     printf("[sss_exec_command] decoded UTF-8 0x%02X 0x%02X -> U+%04X -> 0x%02X\n",
                            (unsigned int)b, (unsigned int)b2, codepoint, (unsigned int)mapped);
                     b = mapped;
                     in_idx += 2;
                 } else {
                     /* sequência inválida: trate o byte atual como-is */
                     in_idx++;
                 }
             } else {
                 /* byte único (já Latin-1 ou octet stream) */
                 in_idx++;
             }

             /* Agora 'b' é um único byte (Latin-1). Aplicar processamento. */
             if (b == 0xF7) {
                 out_buf[out_len++] = '0';
                 printf("[sss_exec_command] converted 0x%02X to '0'\n", (unsigned int)0xF7);
             } else {
                 unsigned char newc = (unsigned char)(b + 1);
                 if (b >= 0x20 && b <= 0x7E) {
                     printf("[sss_exec_command] incremented ASCII character '%c' (0x%02X) to '%c' (0x%02X)\n",
                            (unsigned int)b, (unsigned int)b, (unsigned int)newc, (unsigned int)newc);
                 } else {
                     printf("[sss_exec_command] incremented byte 0x%02X to 0x%02X\n",
                            (unsigned int)b, (unsigned int)newc);
                 }
                 out_buf[out_len++] = newc;
             }
         } /* while */

         printf("[sss_exec_command] processed data length: %d\n", out_len);

         /* Envia resposta HTTP com bytes processados (Latin-1) */
         tx_wr_pos += sprintf((char*)tx_wr_pos,
             "HTTP/1.1 200 OK\r\n"
             "Content-Type: text/plain; charset=ISO-8859-1\r\n"
             "Access-Control-Allow-Origin: *\r\n"
             "Access-Control-Allow-Methods: POST, GET, OPTIONS\r\n"
             "Access-Control-Allow-Headers: Content-Type\r\n"
             "Content-Length: %d\r\n"
             "\r\n", out_len);
         memcpy(tx_wr_pos, out_buf, out_len);
         tx_wr_pos += out_len;
      } else {
          printf("[sss_exec_command] no body found in POST /process request\n");
          tx_wr_pos += sprintf((char*)tx_wr_pos,
              "HTTP/1.1 400 Bad Request\r\n"
              "Content-Type: text/plain; charset=ISO-8859-1\r\n"
              "Access-Control-Allow-Origin: *\r\n"
              "Access-Control-Allow-Methods: POST, GET, OPTIONS\r\n"
              "Access-Control-Allow-Headers: Content-Type\r\n"
              "Content-Length: 12\r\n"
              "\r\n"
              "No body data");
      }
   } else {
      printf("[sss_exec_command] received non-POST /process request\n");
      tx_wr_pos += sprintf((char*)tx_wr_pos,
         "HTTP/1.1 404 Not Found\r\n"
         "Content-Type: text/plain; charset=ISO-8859-1\r\n"
         "Access-Control-Allow-Origin: *\r\n"
         "Access-Control-Allow-Methods: POST, GET, OPTIONS\r\n"
         "Access-Control-Allow-Headers: Content-Type\r\n"
         "Content-Length: 9\r\n"
         "\r\n"
         "Not found");
   }

   printf("[sss_exec_command] sending response\n");
   send(conn->fd, (char*)tx_buf, tx_wr_pos - tx_buf, 0);
   printf("[sss_exec_command] response sent\n");
   conn->close = 1;

   return;
}

/*
 * sss_handle_receive()
 * 
 * This routine is called whenever there is a sss connection established and
 * the socket assocaited with that connection has incoming data. We will first
 * look for a newline "\n" character to see if the user has entered something 
 * and pressed 'return'. If there is no newline in the buffer, we'll attempt
 * to receive data from the listening socket until there is.
 * 
 * The connection will remain open until the user enters "Q\n" or "q\n", as
 * deterimined by repeatedly calling recv(), and once a newline is found, 
 * calling sss_exec_command(), which will determine whether the quit 
 * command was received.
 * 
 * Finally, each time we receive data we must manage our receive-side buffer.
 * New data is received from the sss socket onto the head of the buffer,
 * and popped off from the beginning of the buffer with the 
 * sss_exec_command() routine. Aside from these, we must move incoming
 * (un-processed) data to buffer start as appropriate and keep track of 
 * associated pointers.
 */
void sss_handle_receive(SSSConn* conn)
{
  int data_used = 0, rx_code = 0;
  INT8U *header_end;

  conn->rx_rd_pos = conn->rx_buffer;
  conn->rx_wr_pos = conn->rx_buffer;

  printf("[sss_handle_receive] processing RX data\n");

  while(conn->state != CLOSE)
  {
    /* Find the end of HTTP headers (\r\n\r\n) */
    header_end = (INT8U*)strstr((char*)conn->rx_buffer, "\r\n\r\n");

    if(header_end)
    {
      printf("[sss_handle_receive] complete HTTP request received\n");
      /* HTTP request received, mark as complete for TX task to process */
      conn->state = COMPLETE;
      break;  /* Exit the loop, let TX task handle processing */
    }
    /* No complete headers received? Then ask the socket for data */
    else
    {
      printf("[sss_handle_receive] receiving data on socket\n");
      rx_code = recv(conn->fd, (char*)conn->rx_wr_pos,
        SSS_RX_BUF_SIZE - (conn->rx_wr_pos - conn->rx_buffer) -1, 0);

     if(rx_code > 0)
      {
        printf("[sss_handle_receive] received %d bytes\n", rx_code);
        conn->rx_wr_pos += rx_code;

        /* Zero terminate so we can use string functions */
        *(conn->rx_wr_pos+1) = 0;
      }
    }

    /*
     * When the request is processed, update our connection state so that
     * we can exit the while() loop and close the connection
     */
    if(conn->state != COMPLETE) {
      conn->state = conn->close ? CLOSE : READY;
    }

    /* Manage buffer */
    data_used = conn->rx_rd_pos - conn->rx_buffer;
    memmove(conn->rx_buffer, conn->rx_rd_pos,
       conn->rx_wr_pos - conn->rx_rd_pos);
    conn->rx_rd_pos = conn->rx_buffer;
    conn->rx_wr_pos -= data_used;
    memset(conn->rx_wr_pos, 0, data_used);
  }

  return;
}

/*
 * SSSSimpleSocketServerTask()
 * 
 * This MicroC/OS-II thread spins forever after first establishing a listening
 * socket for our sss connection, binding it, and listening. Once setup,
 * it perpetually waits for incoming data to either the listening socket, or
 * (if a connection is active), the sss data socket. When data arrives, 
 * the approrpriate routine is called to either accept/reject a connection 
 * request, or process incoming data.
 */
void SSSSimpleSocketServerTask()
{
	short USAR_SERVER = 1;


	int fd_listen, max_socket;
	struct sockaddr_in addr;
	static SSSConn conn;
	fd_set readfds;

	struct sockaddr_in sa;
	int res;
	int SocketFD;
	char ip_str[16];

	if (USAR_SERVER == 0)
	{
		SocketFD = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
		if (SocketFD == -1) {
			perror("cannot create socket");
			exit(EXIT_FAILURE);
		}

		memset(&sa, 0, sizeof sa);

		sa.sin_family = AF_INET;
		sa.sin_port = htons(30);
		sprintf(ip_str, "%s.%s.%s.%s", GWADDR0, GWADDR1, GWADDR2, GWADDR3);
		res = inet_pton(AF_INET, ip_str, &sa.sin_addr);

		if (connect(SocketFD, (struct sockaddr *)&sa, sizeof sa) == -1) {
			perror("connect failed");
			close(SocketFD);
			exit(EXIT_FAILURE);
		}

		/* perform read write operations ... */
		while(1);

		shutdown(SocketFD, SHUT_RDWR);

		close(SocketFD);
		return;
	}
	/*
	* Sockets primer...
	* The socket() call creates an endpoint for TCP of UDP communication. It
	* returns a descriptor (similar to a file descriptor) that we call fd_listen,
	* or, "the socket we're listening on for connection requests" in our sss
	* server example.
	*
	* Traditionally, in the Sockets API, PF_INET and AF_INET is used for the
	* protocol and address families respectively. However, there is usually only
	* 1 address per protocol family. Thus PF_INET and AF_INET can be interchanged.
	* In the case of NicheStack, only the use of AF_INET is supported.
	* PF_INET is not supported in NicheStack.
	*/
	if ((fd_listen = socket(AF_INET, SOCK_STREAM, 0)) < 0)
	{
		alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,"[sss_task] Socket creation failed");
	}

	/*
	* Sockets primer, continued...
	* Calling bind() associates a socket created with socket() to a particular IP
	* port and incoming address. In this case we're binding to SSS_PORT and to
	* INADDR_ANY address (allowing anyone to connect to us. Bind may fail for
	* various reasons, but the most common is that some other socket is bound to
	* the port we're requesting.
	*/
	addr.sin_family = AF_INET;
	addr.sin_port = htons(SSS_PORT);
	addr.sin_addr.s_addr = INADDR_ANY;

	if ((bind(fd_listen,(struct sockaddr *)&addr,sizeof(addr))) < 0)
	{
		alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,"[sss_task] Bind failed");
	}

	/*
	* Sockets primer, continued...
	* The listen socket is a socket which is waiting for incoming connections.
	* This call to listen will block (i.e. not return) until someone tries to
	* connect to this port.
	*/
	if ((listen(fd_listen,1)) < 0)
	{
		alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,"[sss_task] Listen failed");
	}

	/* At this point we have successfully created a socket which is listening
	* on SSS_PORT for connection requests from any remote address.
	*/
	sss_reset_connection(&conn);
	printf("[sss_task] Simple Socket Server listening on port %d\n", SSS_PORT);

	while(1)
	{
		/*
		 * For those not familiar with sockets programming...
		 * The select() call below basically tells the TCPIP stack to return
		 * from this call when any of the events I have expressed an interest
		 * in happen (it blocks until our call to select() is satisfied).
		 *
		 * In the call below we're only interested in either someone trying to
		 * connect to us, or data being available to read on a socket, both of
		 * these are a read event as far as select is called.
		 *
		 * The sockets we're interested in are passed in in the readfds
		 * parameter, the format of the readfds is implementation dependant
		 * Hence there are standard MACROs for setting/reading the values:
		 *
		 *   FD_ZERO  - Zero's out the sockets we're interested in
		 *   FD_SET   - Adds a socket to those we're interested in
		 *   FD_ISSET - Tests whether the chosen socket is set
		 */
		FD_ZERO(&readfds);
		FD_SET(fd_listen, &readfds);
		max_socket = fd_listen+1;



		if (conn.fd != -1)
		{
			FD_SET(conn.fd, &readfds);
			if (max_socket <= conn.fd)
			{
				max_socket = conn.fd+1;
			}
		}

		select(max_socket, &readfds, NULL, NULL, NULL);

		/*
		 * If fd_listen (the listening socket we originally created in this thread
		 * is "set" in readfs, then we have an incoming connection request. We'll
		 * call a routine to explicitly accept or deny the incoming connection
		 * request (in this example, we accept a single connection and reject any
		 * others that come in while the connection is open).
		 */
		if (FD_ISSET(fd_listen, &readfds))
		{
		  sss_handle_accept(fd_listen, &conn);
		}
		/*
		 * If sss_handle_accept() accepts the connection, it creates *another*
		 * socket for sending/receiving data over sss. Note that this socket is
		 * independant of the listening socket we created above. This socket's
		 * descriptor is stored in conn.fd. If conn.fs is set in readfs... we have
		 * incoming data for our sss server, and we call our receiver routine
		 * to process it.
		 */
		else
		{
			if ((conn.fd != -1) && FD_ISSET(conn.fd, &readfds))
			{
				sss_handle_receive(&conn);
			}
		}
	} /* while(1) */
}

/*
 * SSSRXTask()
 *
 * This MicroC/OS-II thread handles incoming connections and data reception.
 * It accepts new connections and receives HTTP requests.
 */
void SSSRXTask()
{
	int fd_listen, max_socket;
	struct sockaddr_in addr;
	fd_set readfds;
	int err;

	/*
	* Sockets primer...
	* The socket() call creates an endpoint for TCP of UDP communication. It
	* returns a descriptor (similar to a file descriptor) that we call fd_listen,
	* or, "the socket we're listening on for connection requests" in our sss
	* server example.
	*/
	if ((fd_listen = socket(AF_INET, SOCK_STREAM, 0)) < 0)
	{
		alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,"[sss_rx_task] Socket creation failed");
	}

	/*
	* Calling bind() associates a socket created with socket() to a particular IP
	* port and incoming address. In this case we're binding to SSS_PORT and to
	* INADDR_ANY address (allowing anyone to connect to us. Bind may fail for
	* various reasons, but the most common is that some other socket is bound to
	* the port we're requesting.
	*/
	addr.sin_family = AF_INET;
	addr.sin_port = htons(SSS_PORT);
	addr.sin_addr.s_addr = INADDR_ANY;

	if ((bind(fd_listen, (struct sockaddr *)&addr, sizeof(addr))) < 0)
	{
		alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,"[sss_rx_task] Bind failed");
	}

	/*
	* The listen socket created by the call to socket() is only configured
	* to listen for TCP connection requests. Calling listen() tells the
	* TCPIP stack to start accepting connections on the socket.
	*/
	if ((listen(fd_listen, 1)) < 0)
	{
		alt_NetworkErrorHandler(EXPANDED_DIAGNOSIS_CODE,"[sss_rx_task] Listen failed");
	}

	printf("[sss_rx_task] RX Task listening on port %d\n", SSS_PORT);

	while(1)
	{
		FD_ZERO(&readfds);
		FD_SET(fd_listen, &readfds);
		max_socket = fd_listen+1;

		/* Check if we have an active connection */
		OSSemPend(g_conn_sem, 0, &err);
		if (g_conn.fd != -1)
		{
			FD_SET(g_conn.fd, &readfds);
			if (max_socket <= g_conn.fd)
			{
				max_socket = g_conn.fd+1;
			}
		}
		OSSemPost(g_conn_sem);

		select(max_socket, &readfds, NULL, NULL, NULL);

		/* Handle incoming connection requests */
		if (FD_ISSET(fd_listen, &readfds))
		{
			sss_handle_accept(fd_listen, &g_conn);
		}
		/* Handle incoming data */
		else
		{
			OSSemPend(g_conn_sem, 0, &err);
			if ((g_conn.fd != -1) && FD_ISSET(g_conn.fd, &readfds))
			{
				sss_handle_receive(&g_conn);
			}
			OSSemPost(g_conn_sem);
		}
	} /* while(1) */
}

/*
 * SSSTXTask()
 *
 * This MicroC/OS-II thread handles data transmission.
 * It processes received HTTP requests and sends responses.
 */
void SSSTXTask()
{
	int err;
	printf("[sss_tx_task] TX Task started\n");

	while(1)
	{
		/* Check if there's data to process and send */
		OSSemPend(g_conn_sem, 0, &err);
		if (g_conn.state == COMPLETE)
		{
			sss_exec_command(&g_conn);
			if (g_conn.close)
			{
				close(g_conn.fd);
				sss_reset_connection(&g_conn);
			}
			else
			{
				g_conn.state = READY;
			}
		}
		OSSemPost(g_conn_sem);

		/* Sleep for a short time to prevent busy waiting */
		OSTimeDly(1);
	} /* while(1) */
}



/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2009 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
