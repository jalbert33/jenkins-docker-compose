# install vbox guest additions

# ouvrir un terminal
mkdir -p formation/env/pic
cd formation/env

# Install de Docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce

sudo groupadd docker
sudo usermod -aG docker $USER
docker run hello-world

sudo -i
curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
exit
docker-compose --version

# clone du docker-compose.yml
git clone https://github.com/jalbert33/jenkins-docker-compose.git
docker-compose up -d

sudo chown -R 1000:1000 ~/formation/env/pic
sudo chown -R 200:200 ~/formation/env/pic

sudo nano /etc/systemd/system/docker.service
  
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network.target docker.socket
Requires=docker.socket

[Service]
Type=notify
ExecStart=/usr/bin/docker daemon -H fd:// --dns 8.8.8.8
MountFlags=slave
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity

[Install]
WantedBy=multi-user.target
  
  
sudo systemctl daemon-reload 
sudo systemctl restart docker.service
docker-compose down
docker-compose up -d
  
git clone https://github.com/jalbert33/sample-spring-boot.git