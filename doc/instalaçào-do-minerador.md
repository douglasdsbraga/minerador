1. Primeiro, certifique-se de que o sistema está atualizado. Abra o terminal e execute:
        sudo apt update && sudo apt upgrade -y
2. Instale as dependências necessárias para compilar o cpuminer-opt:
        sudo apt install git build-essential automake autoconf libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev -y
3. Clone o repositório do cpuminer-opt usando o Git:
        git clone https://github.com/JayDDee/cpuminer-opt.git
4. Entre no diretório do cpuminer-opt clonado e compile o código-fonte:
        cd cpuminer-opt
        ./build.sh
5. Após a compilação bem-sucedida, você pode executar o cpuminer-opt com o seguinte comando:
        ./cpuminer -a algoritmo -o url_do_pool -u usuário -p senha

## Nota: 
    As informaçòes: 
        -a algoritmo        : use o comando ./cpuminer --help pra verificar quais algoritimos estào disponíveis/
        -o url_do_pool      : a URL sempre começa com "stratum+tcp://"
        -u usuário          : user worker fornecido pela plataforma do pool
        -p senha            : pass worker fornecido pela plataforma do pool
