Universidade Tecnológica Federal do Paraná - UTFPR
ELEW33-S71 Lógica Reconfigurável
Prática 7 - Interfaceamento NIOS ETHERNET
Projeto Nios II com servidor TCP/IP para processar strings via socket
Prof. Luiz Fernando Copetti

Autores: Matheus Santana e João Pedro Castilho

----------------------------------------------------------------------
PASSO A PASSO RESUMIDO
1. Preparar o ambiente Quartus II 13.0sp1 e descompactar o projeto em `C:\altera\13.0sp1\reconfigurable-logic\nios_ethernet\DE2_NET`.
2. Regenerar o sistema no Qsys, reincluir o `system_0.qip` e compilar o hardware.
3. Instalar o driver do USB-Blaster, manter o Programmer aberto e iniciar o Eclipse Nios II.
4. Ajustar IP, gateway e porta em `simple_socket_server.h`, além de fixar o IP em `system.h`.
5. Compilar (`Build All`), carregar (`Run As -> Nios II Hardware`) e validar o log no console.
6. Executar o `tcpserver.py`, abrir `http://localhost:8080` e enviar strings para teste.
7. Em caso de projetos travados (pastas azuis) ou BSP inconsistente, importar novamente ou regenerar via CLI.

----------------------------------------------------------------------
1) PREPARAÇÃO DO PROJETO NO QUARTUS
1.1 Instale e use o Quartus II 13.0sp1.
1.2 Extraia o `.zip` para obter `DE2_NET` e mova a pasta para `C:\altera\13.0sp1\reconfigurable-logic\nios_ethernet\DE2_NET`.
1.3 Abra `DE2_NET.qpf`.
1.4 Em Project Navigator > Files, remova `system_0/synthesis/system_0.qip`.
1.5 Acesse Tools > Qsys, abra `system_0.qsys` e confirme os diálogos (OK/Close).
1.6 Na aba Generation, clique em `Generate` e aguarde a conclusão.
1.7 Feche o Qsys e volte ao Quartus.
1.8 Em Files > Add/Remove Files in Project, aponte para `system_0/synthesis/system_0.qip`, clique em Add > Apply > OK.

2) CONFIGURAÇÃO DO DRIVER E DA JTAG
2.1 No Windows Defender, desative temporariamente o isolamento de núcleo e a restrição de drivers assinados.
2.2 No Gerenciador de Dispositivos, localize o `Altera USB-Blaster` (ícone amarelo).
2.3 Atualize o driver manualmente: Procurar driver > Permitir escolher da lista > Procurar... > `C:\altera\13.0sp1\quartus\drivers\usb-blaster`.
2.4 Confirme (OK > Avançar > Fechar).
2.5 Abra o Programmer, clique em `Auto Detect`, depois `Start`. Se o progresso ficar verde, deixe o Programmer e a janela “OpenCore Plus Status” abertos.

3) ECLIPSE NIOS II E AJUSTES DE SOFTWARE
3.1 Inicie o Eclipse via Tools > Nios II Software Build Tools for Eclipse.
3.2 Use o workspace `SeuCaminho\DE2_NET\software`.
3.3 Caso `simple_socket` e `simple_socket_bsp` apareçam como pastas amarelas:
     a) Clique com o botão direito em cada projeto e selecione `Clean Project`.
     b) Em `simple_socket_server.h`, ajuste:
        - `IPADDR` para o IP estático da placa (ex.: 192.168.137.10, mesma sub-rede do gateway).
        - `GWADDR` para o gateway (ex.: 192.168.137.1 obtido com `ipconfig`).
        - `SSS_PORT` para a porta HTTP desejada (ex.: 80).
     c) Em `system.h`, comente `#define DHCP_CLIENT` para garantir IP fixo.
     d) Desative firewalls adicionais e libere a porta escolhida no Windows Defender.
     e) Acesse Project > Build All.
     f) Se compilar sem erros, execute `Run As -> Nios II Hardware`.
     g) Alternativa via CLI:
        ```
        cd SeuCaminho\DE2_NET\software\simple_socket
        nios2-download -g simple_socket.elf && nios2-terminal
        ```
     h) Caso o Eclipse trave na execução, basta tentar novamente.
3.4 Log esperado no console Nios II (trecho):
        Using cable "USB-Blaster [USB-0]", device 1, instance 0x00
        ...
        NicheStack TCP/IP Stack initialized.
        HTTP Server starting up
        [sss_rx_task] RX Task listening on port 80
        [sss_tx_task] TX Task started

4) TESTE COM O SERVIDOR TCP PYTHON
4.1 Interrompa o programa em execução no Eclipse.
4.2 Edite `tcpserver.py` para refletir o IP e a porta definidos em `simple_socket_server.h`.
4.3 Execute `python tcpserver.py` no diretório onde o script está.
4.4 Volte ao Eclipse e rode novamente `Run As -> Nios II Hardware`.
4.5 Abra `http://localhost:8080`, digite uma string e clique em “Processar String”.
4.6 Valide os logs:
     - Terminal Python: mensagem do servidor HTTP, IP configurado, requisições servidas.
     - Console Nios II: `accepted connection`, `processing RX data`, `processed data: ...`.
     - Navegador (Console/F12): `Processed String: "<conteúdo>"`.

5) PROJETOS AZUIS (NÃO EXPANDÍVEIS) NO ECLIPSE
5.1 Se `simple_socket` ou `simple_socket_bsp` aparecerem com ícone azul:
     a) Delete apenas do workspace (Remove do Eclipse, sem deletar do disco).
     b) Project Explorer > Import... > Nios II Software Build Tools Project > Import Custom Makefile...
     c) Aponte para `DE2_NET/software/simple_socket_bsp` (Project name `simple_socket_bsp`).
     d) Repita para `DE2_NET/software/simple_socket` (sem “_bsp” no nome).
     e) Retome o fluxo na etapa 3.3(a).

6) REGENERAÇÃO DO BSP (TROUBLESHOOTING)
6.1 Abra o Nios II Command Shell com o PATH configurado.
6.2 Execute:
        cd C:\altera\13.0sp1\reconfigurable-logic\nios_ethernet\DE2_NET\software\simple_socket_bsp
        nios2-bsp ucosii . system_0.sopcinfo --set hal.make.bsp_cflags_defined_symbols -DTSE_MY_SYSTEM --cmd enable_sw_package altera_iniche
        nios2-bsp-generate-files --settings=settings.bsp --bsp-dir=.
        make
        cd ../simple_socket
        make
6.3 Retorne ao Eclipse e faça `Project > Build All`.

Com isso, o projeto fica pronto para demonstrar o processamento de strings no Nios II com supervisão do servidor Python desenvolvido por Matheus Santana e João Pedro Castilho.
