import socket
import json
from http.server import BaseHTTPRequestHandler, HTTPServer
import threading
import argparse

# Configuration
PORTA_HTTP_SERVIDOR = 8080
ENDERECO_IP_NIOS = "192.168.137.10"  # Static NIOS IP in same subnet as PC
PORTA_SERVICO_NIOS = 80            # Default NIOS webserver port

# Parse command line arguments
parser_cli = argparse.ArgumentParser(description='PC HTTP Server for NIOS String Processor')
parser_cli.add_argument('--nios-port', type=int, default=PORTA_SERVICO_NIOS, help='NIOS webserver port (default: 80)')
argumentos = parser_cli.parse_args()
PORTA_SERVICO_NIOS = argumentos.nios_port

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        try:
            if self.path == '/':
                self.send_response(200)
                self.send_header('Content-type', 'text/html')
                self.end_headers()
                try:
                    with open('index.html', 'rb') as f:
                        self.wfile.write(f.read())
                    print("Served index.html successfully")
                except FileNotFoundError:
                    mensagem_erro = b'<html><body><h1>index.html not found</h1></body></html>'
                    self.wfile.write(mensagem_erro)
                    print("index.html not found")
            elif self.path == '/get_nios_ip':
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                resposta_cfg = {'ip': ENDERECO_IP_NIOS, 'port': PORTA_SERVICO_NIOS}
                self.wfile.write(json.dumps(resposta_cfg).encode())
                print(f"Served NIOS IP: {ENDERECO_IP_NIOS}:{PORTA_SERVICO_NIOS}")
            else:
                self.send_response(404)
                self.send_header('Content-type', 'text/html')
                self.end_headers()
                self.wfile.write(b'<html><body><h1>404 Not Found</h1></body></html>')
                print(f"404 for path: {self.path}")
        except Exception as e:
            print(f"Error in do_GET: {e}")
            self.send_response(500)
            self.end_headers()

    def log_message(self, format, *args):
        # Suppress default logging
        pass

if __name__ == '__main__':
    print("PC HTTP Server for NIOS String Processor")
    print(f"Server running on port {PORTA_HTTP_SERVIDOR}")
    print(f"NIOS IP configured as: {ENDERECO_IP_NIOS}:{PORTA_SERVICO_NIOS}")
    print("Open http://localhost:8080 in your browser")

    endereco_servidor = ('', PORTA_HTTP_SERVIDOR)
    servidor_http = HTTPServer(endereco_servidor, SimpleHTTPRequestHandler)
    try:
        servidor_http.serve_forever()
    except KeyboardInterrupt:
        print("\nHTTP Server stopped")
        servidor_http.shutdown()
