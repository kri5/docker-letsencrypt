FROM ubuntu

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update && apt-get install -qqy git wget cron bc xz-utils

#Install lego
RUN wget -q https://github.com/xenolf/lego/releases/download/v0.3.1/lego_linux_amd64.tar.xz
RUN tar xf lego_linux_amd64.tar.xz
RUN chmod +x lego

# Install kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v1.2.2/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/

# Add some helper scripts for getting and saving scripts later
ADD fetch_certs.sh /letsencrypt/
ADD save_certs.sh /letsencrypt/
ADD recreate_pods.sh /letsencrypt/
ADD refresh_certs.sh /letsencrypt/
ADD start.sh /letsencrypt/

RUN mv lego/lego /letsencrypt

WORKDIR /letsencrypt

ENTRYPOINT ./start.sh
