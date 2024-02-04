FROM containerssh/agent AS agent

FROM alpine

# copy in containerssh-agent
COPY --from=agent /usr/bin/containerssh-agent /usr/bin/containerssh-agent

# add pre-reqs for required installs
RUN apk add --update --no-cache curl bash jq yq git net-tools vim

# download and install kubectl
RUN cd /tmp && VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)" \
    && curl -LO "https://dl.k8s.io/release/$VERSION/bin/linux/amd64/kubectl" \
    && curl -LO "https://dl.k8s.io/$VERSION/bin/linux/amd64/kubectl.sha256" \
    && echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# download and install k3d
RUN wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# download and install helm
RUN cd /tmp && VERSION="$(curl -L -s https://get.helm.sh/helm-latest-version)" \
    && curl -LO "https://get.helm.sh/helm-$VERSION-linux-amd64.tar.gz" \ 
    && curl -LO "https://get.helm.sh/helm-$VERSION-linux-amd64.tar.gz.sha256sum" \
    && echo "$(cat helm-$VERSION-linux-amd64.tar.gz.sha256sum | awk '{ print $1 }')  helm-$VERSION-linux-amd64.tar.gz" | sha256sum -c \
    && tar -zxvf "helm-$VERSION-linux-amd64.tar.gz" \
    && install -o root -g root -m 0755 linux-amd64/helm /usr/local/bin/helm

# add helm-diff
RUN helm plugin install https://github.com/databus23/helm-diff && rm -rf /tmp/helm-*
RUN rm -r /tmp/*

# copy over k3d config file
COPY ./k3dconfig.yml /etc/k3dconfig.yml

# copy over scripts + make executable
COPY ./scripts/. /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# copy over bash config
COPY ./bash_profile /root/.bash_profile
COPY ./bash_logout /root/.bash_logout
COPY ./bashrc /root/.bashrc

WORKDIR /root

# copy in lab
COPY --from=lab . /root