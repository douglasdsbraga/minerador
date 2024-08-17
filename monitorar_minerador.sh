#!/bin/bash

# Configurações
TEMPERATURA_MAXIMA=94.9
PAUSA_REINICIO=2400  # 40 minutos em segundos
CAMINHO_CPUMINER=/caminho/para/o/minerador
SERVICO_NAME=nome_minerador.service

# Função para obter a média das temperaturas do CPU
get_cpu_temp_avg() {
    # Obtém a média das temperaturas
    TEMP_AVG=$(sensors | grep 'Core' | awk '{print $3}' | sed 's/+//;s/°C//' | awk '{sum+=$1; count++} END{if (count > 0) print sum / count}')
    
    # Remove casas decimais usando awk para garantir que a entrada para printf seja válida
    TEMP_AVG=$(echo "$TEMP_AVG" | awk '{printf "%.1f", $1}')
    echo "$TEMP_AVG"
}

# Função para reiniciar o minerador
restart_miner() {
    echo "Reiniciando minerador..."
    systemctl restart $SERVICO_NAME
}

# Monitoramento e controle
while true; do
    CURRENT_TEMP=$(get_cpu_temp_avg)

    # Mensagens de depuração
    echo "Temperatura média atual: $CURRENT_TEMP°C"

    # Comparação usando bc
    COMPARE=$(echo "$CURRENT_TEMP >= $TEMPERATURA_MAXIMA" | bc -l)
    if [ "$COMPARE" -eq 1 ]; then
        echo "Temperatura média $CURRENT_TEMP°C excedeu o limite de $TEMPERATURA_MAXIMA°C. Parando o minerador..."
        systemctl stop $SERVICO_NAME

        # Esperar antes de reiniciar
        sleep $PAUSA_REINICIO

        echo "Reiniciando o minerador após a pausa..."
        restart_miner
    fi

    # Aguarda 60 segundos antes de verificar novamente
    sleep 60
done