# Use a imagem base do Ubuntu
FROM ubuntu:20.04

# Definir o frontend para não interativo e o fuso horário
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

# Atualizar e instalar as dependências necessárias
RUN apt-get update && \
    apt-get install -y \
    tzdata \
    build-essential \
    autoconf \
    automake \
    libcurl4-openssl-dev \
    libssl-dev \
    libjansson-dev \
    libgmp-dev \
    pkg-config \
    git && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Clonar o repositório do cpuminer-opt e compilar
RUN git clone https://github.com/JayDDee/cpuminer-opt.git cpuminer-opt && \
    cd cpuminer-opt && \
    ./autogen.sh && \
    ./configure CFLAGS="-O3" CXXFLAGS="-O3" LDFLAGS="-lcurl -lpthread" && \
    make -j$(nproc)  
    # Compila utilizando múltiplos núcleos

# Comando padrão para o container (ajuste conforme necessário)
CMD ["/cpuminer-opt/cpuminer", "-a", "ethash", "-o", "stratum+tcp://etc.poolbinance.com:1800", "-u", "baleiaAzui.001", "-p", "123456"]