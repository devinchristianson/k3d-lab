FROM containerssh/agent AS agent

FROM alpine
# copy in containerssh-agent
COPY --from=agent /usr/bin/containerssh-agent /usr/bin/containerssh-agent
# add pre-reqs for required installs
RUN apk add curl bash
# download and install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# download and install k3d
RUN wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
WORKDIR /root
# copy over k3d config file
COPY ./k3dconfig.yml /etc/k3dconfig.yml
COPY ./scripts /root/scripts
RUN chmod +x /root/scripts/*