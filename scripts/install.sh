#!/bin/bash
# Install kubectl if not installed
package=kubectl
if ! which $package; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/${package}"
    sudo install -o root -g root -m 0755 ${package} /usr/local/bin/${package}
fi
# install helm if not installed
package=helm
if ! which $package; then
   wget https://get.${package}.sh/${package}-v3.7.2-linux-amd64.tar.gz
   tar ${package}-v3.7.2-linux-amd64.tar.gz
   sudo chmod +x linux-amd64/${package}
   sudo mv linux-amd64/${package} /usr/local/bin/${package}
fi
# Install minikube if not installed
package=minikube
if ! which $package; then
    curl -LO https://storage.googleapis.com/${package}/releases/latest/${package}-linux-amd64
    sudo install ${package}-linux-amd64 /usr/local/bin/${package}
fi
# Install docker if not installed
package=docker
if ! which $package; then
    curl -fsSL https://get.${package}.com -o get-${package}.sh
    sudo sh get-${package}.sh
fi
sudo chmod 666 /var/run/docker.sock
# Install docker-compose if not installed
package=docker-compose
if ! which $package; then
    sudo curl -L "https://github.com/$(echo ${package} | cut -d '-' -f 1)/$(echo ${package} | cut -d '-' -f 2)/releases/download/1.29.2/${package}-$(uname -s)-$(uname -m)" -o /usr/local/bin/${package}
    sudo chmod +x /usr/local/bin/${package}
fi
