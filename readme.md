# Projeto de mineração em cima da CPU

## controle sobre o serviço
Criado em: 
[sudo nano /etc/systemd/system/cpuminer.service](./doc/minerador-em-segundo-plano.md)
Com os controles via systemctl:
sudo systemctl status cpuminer
sudo systemctl stop cpuminer
sudo systemctl start cpuminer
sudo systemctl restart cpuminer

## Monitoramento dos Log's do cpuminer.service
sudo journalctl -u cpuminer -f


## Como este projeto está organizado?

Basicamente é um proejto em que teve algumas tentativas, tanto via docker asism como instaçõa nativa. Como os mineradores são ferramentas que visam funcionar muito mais para o lado hardware, uma instação via docker ou VM não é uma vantagem pois estes estào na camada mais acima onde a abstração é mais complexa por assim dizer, ou seja, mais longe do hardware.

A mineração pelo que entendi até o presente momento, 16 de agosto de 2024, é que se trata de um funcionamenot que está intimamente ligado ao hardware e quanto mais abstrações a nivel de software mais complexo e exigente é o processo. 

### NOTA: 
1. vale uma tentativa de rodar o hiveOS dentro do docker par apoder ver o funcionamento porém assim como um minerador em cima de uma cPU ( Processador ), o funcionamento é limitado. 
2. a mineraçào com GPU é mais eficiente, fato. Mas par aum funcionamento efeicaz e eficiente de fato a linha é mais para o lado ou de uma ASCI ou uma Rig  ( uam espécie de cluster de placa de videos... )

---

## Guia de instação do cpuminer-opt

1. [instalação do minerador e como executar](./doc/instalaçào-do-minerador.md)
2. [Criando um serviço para o minerador funcionar em segundo plano sem necessidade do terminal](./doc/minerador-em-segundo-plano.md)
3. [Criar um Script de Monitoramento da Temperatura](./doc/minerador-script-de-monitoramenot.md)