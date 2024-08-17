# Criar um Script de Monitoramento da Temperatura

Para monitorar a temperatura da CPU e parar o serviço quando a temperatura atingir 95°C, você pode usar um script de monitoramento. Vamos usar sensors para obter a temperatura da CPU.

1.	Instale o pacote lm-sensors para monitorar a temperatura:
        sudo apt-get install lm-sensors
        sudo sensors-detect
2.	Crie um script de monitoramento, por exemplo, monitor_temp.sh, no diretório /usr/local/bin/:
        sudo nano /usr/local/bin/monitor_temp.sh

3.	Adicione o seguinte conteúdo ao script:
   
    #!/bin/bash

    # Configurações
    TEMPERATURA_MAXIMA=95
    PAUSA_REINICIO=2400  # 40 minutos em segundos
    CAMINHO_CPUMINER=/caminho/para/o//minerador/cpuminer
    SERVICO_NAME=cpuminer.service

    # Função para obter a temperatura atual do CPU
    get_cpu_temp() {
        TEMP=$(sensors | grep 'Core 0:' | awk '{print int($3 + 0.5)}' | sed 's/+//;s/°C//')
        TEMP=$(echo "$TEMP" | awk '{print int($1)}')
        echo "$TEMP"
    }

    # Função para reiniciar o minerador
    restart_miner() {
        echo "Reiniciando minerador..."
        systemctl restart $SERVICO_NAME
    }

    # Monitoramento e controle
    while true; do
        CURRENT_TEMP=$(get_cpu_temp)

        # Mensagens de depuração
        echo "Temperatura atual: $CURRENT_TEMP°C"

        if [ "$CURRENT_TEMP" -ge "$TEMPERATURA_MAXIMA" ]; then
            echo "Temperatura $CURRENT_TEMP°C excedeu o limite de $TEMPERATURA_MAXIMA°C. Parando o minerador..."
            systemctl stop $SERVICO_NAME

            # Esperar antes de reiniciar
            sleep $PAUSA_REINICIO

            echo "Reiniciando o minerador após a pausa..."
            restart_miner
        fi

        # Aguarda 60 segundos antes de verificar novamente
        sleep 60
    done

4.	Torne o script executável:
        sudo chmod +x /usr/local/bin/monitor_temp.sh

5.	Crie um cron job para executar o script regularmente:
    
    Edite o crontab para adicionar uma entrada para executar o script a cada minuto:
    crontab -e
    
    Adicione a seguinte linha ao crontab:
    * * * * * /usr/local/bin/monitor_temp.sh

    Isso garante que o script seja executado a cada minuto para verificar a temperatura.

# Em Resumo

1. Serviço systemd: Crie um arquivo de serviço para gerenciar o cpuminer, permitindo iniciar, parar e reiniciar o minerador com systemctl.
2. Monitoramento de Temperatura: Crie um script para monitorar a temperatura da CPU e parar o serviço se a temperatura exceder 95°C. Utilize cron para executar o script periodicamente.

Esses passos permitem que gerencie o cpuminer eficientemente e proteja seu sistema de temperaturas excessivas.

-----------------------------------------------------------------

# Crie o Arquivo de Log com Permissões Adequadas

Crie o arquivo de log manualmente com as permissões adequadas e ajuste a propriedade para o usuário que executará o script.

sudo touch /var/log/monitorar_minerador.log
sudo chown douglas:douglas /var/log/monitorar_minerador.log

Então, execute o script:

sudo nohup /caminho/para/monitorar_minerador.sh > /var/log/monitorar_minerador.log 2>&1 &

# Redirecione a Saída para um Diretório com Permissões Adequadas

Em vez de usar um diretório restrito como /var/log, redirecione a saída para um diretório onde o usuário atual tem permissão de escrita, como seu diretório pessoal:

nohup /caminho/para/monitorar_minerador.sh > /home/douglas/monitorar_minerador.log 2>&1 &

## Execute o Script com Permissões de Superusuário
Você pode iniciar o script diretamente como root e garantir que ele tenha permissões adequadas para escrever no diretório /var/log:

sudo nohup /caminho/para/monitorar_minerador.sh > /var/log/monitorar_minerador.log 2>&1 &

configurar Permissões do Diretório /var/log

Como alternativa, ajuste as permissões do diretório /var/log para permitir gravação pelo seu usuário, mas isso é menos seguro e não recomendado para ambientes de produção.

sudo chmod 777 /var/log

Resumo

A solução mais segura é criar o arquivo de log com as permissões adequadas ou redirecionar a saída para um diretório onde o usuário tem permissões de escrita. Ajustar permissões no diretório /var/log deve ser evitado para manter a segurança.