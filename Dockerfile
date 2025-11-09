FROM python:3.11-slim

RUN apt-get update && \
    apt-get install -y git wget tar ca-certificates && \
    update-ca-certificates && \
    wget --no-check-certificate https://github.com/OJ/gobuster/releases/download/v3.8.2/gobuster_Linux_x86_64.tar.gz && \
    tar -xzf gobuster_Linux_x86_64.tar.gz && \
    mv gobuster /usr/local/bin/ && \
    rm gobuster_Linux_x86_64.tar.gz && \
    rm -rf /var/lib/apt/lists/*

# kyubi install
RUN git -c http.sslVerify=false clone https://github.com/shibli2700/Kyubi.git &&\
     cd Kyubi && pip3 install --trusted-host pypi.org --trusted-host files.pythonhosted.org . && cd ..


# nginxpwner python dependencies install
COPY requirements.txt .

RUN pip3 install --trusted-host pypi.org --trusted-host files.pythonhosted.org --timeout 1000 -r requirements.txt

COPY nginxpwner.py nginx-pwner-no-server-header.py ./

