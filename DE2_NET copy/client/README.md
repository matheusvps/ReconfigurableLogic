# Cliente Web - String Processor

Este diretório contém o cliente web para comunicação com a placa DE2/Cyclone 10.

## Arquivos

- `index.html`: Página HTML com interface para envio de strings

## Como Usar

1. Abra o arquivo `index.html` em um navegador web moderno
2. Configure o IP da placa (obtido via DHCP) e a porta (80)
3. Digite uma string de até 100 caracteres
4. Clique em "Processar String"
5. O resultado será exibido na página

## Requisitos

- Navegador web moderno com suporte a JavaScript e Fetch API
- A placa DE2/Cyclone 10 deve estar conectada à mesma rede
- O servidor web na placa deve estar rodando na porta 80

## Funcionalidades

- Interface web simples e intuitiva
- Validação de entrada (máximo 100 caracteres)
- Contador de caracteres em tempo real
- Exibição de resultados (string original e processada)
- Mensagens de status (sucesso, erro, informação)
- Configuração de IP e porta da placa

## Notas

- A página HTML pode ser aberta localmente no PC (não requer servidor web)
- A comunicação é feita via HTTP POST para a placa
- O processamento é realizado pelo User_HW na placa FPGA

