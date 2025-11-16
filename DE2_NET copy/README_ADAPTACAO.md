# Adaptação do Projeto DE2_NET para Requisitos Específicos

Este documento descreve as adaptações realizadas no projeto DE2_NET copy para atender aos requisitos especificados.

## Requisitos Implementados

### 1. Web Server no NIOS
- ✅ Implementado servidor HTTP simples na porta 80
- ✅ Arquivos: `software/simple_socket/web_server.h` e `web_server.c`
- ✅ Suporta requisições GET (formulário HTML) e POST (processamento de strings)

### 2. Cliente no PC
- ✅ Página HTML criada em `client/index.html`
- ✅ Interface web moderna com JavaScript para comunicação HTTP
- ✅ Permite envio de strings de até 100 caracteres
- ✅ Exibe resultado processado pela placa

### 3. DHCP no NIOS
- ✅ Configurado no NicheStack TCP/IP
- ✅ O código aguarda `iniche_net_ready` antes de iniciar o servidor
- ✅ IP é obtido automaticamente do servidor DHCP da rede

### 4. Conexão no Mesmo Servidor DHCP
- ✅ Placa e PC devem estar na mesma rede
- ✅ Ambos obtêm IP do mesmo servidor DHCP

### 5. Duas Threads no NIOS
- ✅ **Thread de Recepção** (`WebServerRxTask`): Recebe pacotes HTTP
- ✅ **Thread de Transmissão** (`WebServerTxTask`): Envia respostas HTTP
- ✅ Prioridades: RX=5, TX=6

### 6. Página HTML no PC
- ✅ Arquivo: `client/index.html`
- ✅ Campo de entrada com limite de 100 caracteres
- ✅ Contador de caracteres em tempo real
- ✅ Exibição de resultados (string original e processada)
- ✅ Pode ser aberta localmente (não requer servidor web no PC)

### 7. User_HW - Processamento de Strings
- ✅ Componente VHDL: `User_HW.vhd`
- ✅ Processa strings de até 100 caracteres
- ✅ Soma 1 a cada caractere ASCII
- ✅ Se caractere = 0xF7, transforma em 0x00
- ✅ Interface Avalon para comunicação com NIOS

### 8. Transmissão de String Modificada
- ✅ Placa processa string via User_HW
- ✅ Retorna string modificada via HTTP
- ✅ Cliente exibe resultado na página HTML

## Estrutura de Arquivos

```
DE2_NET copy/
├── User_HW.vhd                    # Componente hardware para processamento
├── software/simple_socket/
│   ├── web_server.h               # Header do servidor web
│   ├── web_server.c               # Implementação do servidor web
│   └── iniche_init.c              # Inicialização (modificado)
└── client/
    ├── index.html                 # Página HTML do cliente
    └── README.md                  # Documentação do cliente
```

## Como Usar

### 1. Configuração do Hardware (Quartus/Qsys)
1. Adicionar componente `User_HW.vhd` ao sistema Qsys
2. Conectar interface Avalon ao barramento do NIOS
3. Configurar endereço base do User_HW
4. Atualizar `system.h` com o endereço base definido

### 2. Compilação do Software
1. Abrir projeto no Nios II IDE
2. Adicionar arquivos `web_server.h` e `web_server.c` ao projeto
3. Atualizar `USER_HW_BASE` em `web_server.h` com o endereço correto
4. Compilar projeto

### 3. Configuração da Rede
1. Conectar placa DE2/Cyclone 10 à rede via cabo Ethernet
2. Conectar PC à mesma rede
3. Aguardar placa obter IP via DHCP
4. Verificar IP no terminal do NIOS ou via servidor DHCP

### 4. Execução
1. Programar FPGA com bitstream compilado
2. Executar software no NIOS
3. Abrir `client/index.html` no navegador
4. Configurar IP da placa na página
5. Digitar string e clicar em "Processar String"

## Registradores User_HW

| Endereço | Função | Descrição |
|----------|--------|-----------|
| 0x00 | DATA_IN | Escrita de caracteres (sequencial) |
| 0x04 | DATA_OUT | Leitura de caracteres processados (sequencial) |
| 0x08 | CONTROL | Controle (bit 0 = start processing) |
| 0x0C | LENGTH | Comprimento da string (0-100) |

## Protocolo de Comunicação

### Requisição HTTP POST
```
POST / HTTP/1.1
Content-Type: application/x-www-form-urlencoded

string=<string_a_processar>
```

### Resposta HTTP
```
HTTP/1.1 200 OK
Content-Type: text/html

<html>
  <body>
    <p><strong>Input:</strong> <string_original></p>
    <p><strong>Output:</strong> <string_processada></p>
    ...
  </body>
</html>
```

## Notas Importantes

1. **DHCP**: Certifique-se de que há um servidor DHCP na rede
2. **Endereço User_HW**: Deve ser configurado corretamente no Qsys e no código
3. **Threads**: As duas threads (RX e TX) são obrigatórias conforme requisito
4. **Limite de String**: Máximo de 100 caracteres conforme especificado
5. **Processamento**: Caractere 0xF7 é transformado em 0x00, outros são incrementados

## Troubleshooting

- **Placa não obtém IP**: Verificar conexão Ethernet e servidor DHCP
- **Erro ao processar string**: Verificar endereço base do User_HW
- **Página não conecta**: Verificar IP da placa e porta 80
- **Resultado incorreto**: Verificar lógica de processamento no User_HW

