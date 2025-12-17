## Laboratório Final – Projeto Nios II + Ethernet + Servidor TCP

Este diretório reúne o **material do projeto final de Lógica Reconfigurável**, baseado em um sistema Nios II rodando sobre a placa DE2, com interface **Ethernet** e comunicação com um **servidor TCP/IP em um PC** (scripts Python e, opcionalmente, interface gráfica). A partir deste material, deve ser possível **reconstruir completamente o projeto de cada equipe**.

---

## Objetivo do projeto e interação com outros projetos

- **Objetivo principal**: implementar um sistema embarcado em FPGA (Nios II + periféricos) capaz de comunicar via TCP/IP com uma aplicação em um PC, realizando processamento ou transmissão de dados (por exemplo, strings, arquivos ou amostras de áudio) e apresentando resultados em periféricos da placa (LCD, LEDs, etc.) e/ou na aplicação em alto nível.
- **Projeto base**: o sistema é derivado do projeto de referência `DE2_NET` (Nios + Ethernet) usado em outras práticas (por exemplo, o projeto em `NiosEthernet/DE2_NET`). O **README.txt** dentro de `NiosEthernet` descreve o passo a passo detalhado do projeto base e serve como documentação complementar.
- **Interação com outros diretórios**:
  - `LabFinal/DE2_NET`: versão do projeto de hardware (Quartus/Qsys) utilizada pela equipe no trabalho final.
  - `LabFinal/NiosAndUserHW.zip` e `LabFinal/NiosAndUserHWImpl.zip`: arquivos compactados com variações do hardware/sistema Nios II (e documentação adicional) usadas como referência ou parte da implementação final.
  - `LabFinal/TCPServer` e `LabFinal/tcpserver.py`: implementação do servidor TCP/IP em Python, incluindo scripts e, opcionalmente, interface gráfica.
  - `LabFinal/audios`: arquivos de teste (por exemplo, arquivos `.wav`) utilizados em demonstrações de transmissão/ processamento de áudio.

---

## Descrição dos módulos

- **Módulos de hardware (VHDL / Quartus / Qsys)**  
  - Projeto principal em `DE2_NET` (nesta pasta ou nos arquivos `.zip` fornecidos).  
  - Inclui o sistema Nios II, controladores de memória, interface Ethernet (TSE), GPIOs, LCD, entre outros periféricos.  
  - Arquivos relevantes:
    - Arquivo de projeto Quartus (`.qpf`, `.qsf`);
    - Sistema Qsys/platform designer (`system_0.qsys` e arquivos gerados, como `system_0.qip`);
    - Módulos VHDL adicionais desenvolvidos pela equipe (por exemplo, controladores de exibição, lógica de seleção de arquivos, filtros, etc.).

- **Módulos de software embarcado (C / C++ sobre Nios II)**  
  - Localizados no subdiretório `DE2_NET/software` (ou dentro dos projetos descompactados dos `.zip`).  
  - Projetos típicos:
    - `simple_socket` (aplicação Nios II);
    - `simple_socket_bsp` (BSP, incluindo NicheStack TCP/IP).  
  - Códigos em C/C++ tratam:
    - Configuração de IP, porta e gateway;
    - Inicialização da pilha TCP/IP;
    - Recepção/transmissão de dados via socket;
    - Comunicação com periféricos da placa (LCD, chaves, botões, etc.).

- **Módulos de software em PC (Python / interação com o sistema operacional)**  
  - Script principal `tcpserver.py` (nesta pasta) e arquivos em `TCPServer/`.  
  - Funções típicas:
    - Criação de socket TCP ouvindo na porta configurada no Nios II;
    - Recepção/envio de dados (strings, comandos ou blocos de dados);
    - Integração com o sistema operacional (abertura de arquivos, leitura de áudios em disco, logs no terminal);
    - Eventual GUI (`gui_app.py` ou similar) para facilitar o teste na máquina do usuário.  
  - Dependências Python e ambiente virtual podem ser definidos em `TCPServer/venv_fft` ou outro ambiente virtual documentado no próprio diretório.

---

## Detalhes de implementação

- **Fluxo de desenvolvimento de hardware (Quartus/Qsys)**  
  - Criação/ajuste do sistema `system_0.qsys` com processador Nios II, interface Ethernet, memória e periféricos necessários.  
  - Geração dos arquivos do sistema (`Generate` no Qsys) e reinclusão do arquivo `system_0.qip` no projeto Quartus.  
  - Compilação do projeto (`Compile`) e verificação da conectividade JTAG/USB-Blaster via `Programmer`.

- **Fluxo de desenvolvimento de software Nios II (Eclipse / Nios II SBT)**  
  - Configuração do workspace para `DE2_NET/software`.  
  - Importação/limpeza dos projetos `simple_socket` e `simple_socket_bsp`.  
  - Ajuste de IP, porta, gateway e demais parâmetros de rede nos arquivos de configuração (`simple_socket_server.h`, `system.h`, `iniche_init.c` ou equivalentes, dependendo da variação do projeto).  
  - Compilação (`Build All`) e gravação/execução no hardware (`Run As -> Nios II Hardware` ou via CLI com `nios2-download` e `nios2-terminal`).

- **Fluxo de desenvolvimento do servidor TCP (Python)**  
  - Ajuste dos parâmetros de IP e porta em `tcpserver.py` para casar com os valores configurados no Nios II.  
  - Execução do servidor via terminal (`python tcpserver.py`) e monitoramento dos logs.  
  - Integração opcional com interface gráfica (por exemplo, seleção de arquivos de áudio, visualização textual dos dados processados, etc.).

- **Uso de arquivos de teste (por exemplo, áudios)**  
  - A pasta `audios/` contém arquivos usados nos testes/demonstrações.  
  - O servidor Python pode carregar esses arquivos a partir do sistema de arquivos e enviá‑los ou processá‑los sob demanda, conforme definido na lógica da equipe.

---

## Como reconstruir o projeto da equipe

1. **Pré-requisitos**  
   - Quartus II 13.0sp1 (ou versão especificada nos documentos da disciplina);  
   - Nios II Software Build Tools (Eclipse ou versão em linha de comando);  
   - Cabo USB‑Blaster corretamente instalado;  
   - Python 3.x instalado no PC (para `tcpserver.py` e demais scripts).

2. **Obter o material**  
   - Baixe/clon e este repositório (ou o pacote fornecido pela disciplina).  
   - Certifique‑se de que os arquivos `.zip` presentes em `LabFinal` (`NiosAndUserHW.zip`, `NiosAndUserHWImpl.zip` e outros, se houver) estejam descompactados conforme instruções da disciplina, mantendo a hierarquia original das pastas.

3. **Recriar o hardware (Quartus/Qsys)**  
   - Abra o projeto `DE2_NET.qpf` dentro da árvore `LabFinal/DE2_NET` ou dentro das pastas resultantes dos `.zip`.  
   - Siga as instruções de regeneração de Qsys, inclusão do arquivo `system_0.qip` e compilação descritas em:
     - `LabFinal/ME_LEIA.txt` (instruções específicas de uma das equipes);  
     - `NiosEthernet/README.txt` (passo a passo detalhado do projeto base).  
   - Programe a FPGA usando o `Programmer` e verifique se o progresso é concluído com sucesso.

4. **Recriar o software Nios II**  
   - No Eclipse/Nios II SBT, selecione o workspace para `.../DE2_NET/software`.  
   - Importe ou limpe os projetos `simple_socket` e `simple_socket_bsp`.  
   - Ajuste os parâmetros de IP/porta/gateway nos arquivos de configuração da aplicação.  
   - Faça `Build All` e, em seguida, `Run As -> Nios II Hardware` (ou use as ferramentas de linha de comando equivalentes).

5. **Preparar e executar o servidor TCP (PC)**  
   - Acesse o diretório `LabFinal` e ajuste o IP/porta em `tcpserver.py`.  
   - Se estiver usando o diretório `TCPServer`, ative o ambiente virtual ou instale as dependências conforme documentação local (por exemplo, `source venv_fft/bin/activate` ou similar).  
   - Execute `python tcpserver.py` (ou a aplicação gráfica, se houver).  
   - Valide a comunicação verificando logs no terminal Python, console Nios II e comportamento do sistema (LCD, LEDs, GUI, etc.).

---

## Sobre o README.TXT e materiais grandes

- **README.TXT por equipe**  
  - Cada conjunto de arquivos de equipe deve conter um `README.TXT` (ou equivalente, como `ME_LEIA.txt`) com:
    - Descrição dos arquivos e pastas relevantes;
    - Versão de ferramentas utilizadas;
    - Eventuais passos específicos que complementem este `README.md`.  
  - O arquivo `NiosEthernet/README.txt` já contém o guia detalhado para o projeto base Nios + Ethernet e é uma referência importante.

- **Links para armazenamento externo**  
  - Caso o material completo de alguma equipe seja grande demais para ser incluído diretamente aqui (por exemplo, imagens de disco, conjuntos extensos de áudios, etc.), o **README.TXT correspondente deve indicar claramente o link de armazenamento** (Drive, Git, etc.).  
  - Sugestão de formato:
    - *Link oficial de armazenamento do material completo da equipe: `<URL A SER INSERIDA PELA EQUIPE>`*

Com as informações deste `README.md`, dos `README.TXT`/`ME_LEIA.txt` de cada conjunto de arquivos e do `README.txt` em `NiosEthernet`, um usuário deve ser capaz de **baixar o material, configurar o ambiente e reconstruir o projeto completo de cada equipe**.