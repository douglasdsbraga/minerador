# Criar um Serviço Systemd para o cpuminer

1.  Crie o arquivo de serviço:
    Abra um editor de texto para criar um arquivo de serviço no diretório /etc/systemd/system/. Vamos chamar o arquivo de cpuminer.service:
        sudo nano /etc/systemd/system/cpuminer.service

2.	Adicione o seguinte conteúdo ao arquivo:

    [Unit]
    Description=CPUMiner Service
    After=network.target

    [Service]
    ExecStart=/path/to/cpuminer -a sha256d -o stratum+tcp://bch.poolbinance.com:1800 -u usuario -p pass -t 1
    WorkingDirectory=/path/to/miner
    Restart=always
    User=yourusername
    Group=yourusername
    LimitNOFILE=4096
    LimitNPROC=4096

    [Install]
    WantedBy=multi-user.target

    ### IMPORTANTE: 
     Substitua /path/to/cpuminer e /path/to/miner pelo caminho real onde o cpuminer está localizado e onde você deseja definir o diretório de trabalho. Substitua yourusername pelo seu nome de usuário.


3.	Recarregue o systemd e inicie o serviço:
        sudo systemctl daemon-reload
        sudo systemctl start cpuminer


4.	Habilite o serviço para iniciar automaticamente na inicialização:
        sudo systemctl enable cpuminer


5.	Verifique o status do serviço:
        sudo systemctl status cpuminer