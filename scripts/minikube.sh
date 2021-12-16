#!/bin/bash 
# Add current user to docker group for connectiong to docker dameon as non root user
# Start k8s cluster if not started
if ! minikube status > /dev/null;
    then
    minikube start > /dev/null 2>&1 &
while ! kubectl get pods 2> /dev/null; do
    clear
    echo "Waiting for creating minikube cluster..."
   
done
echo "The cluster is ready to use!"   
# Configure ingress controller
echo "Enable ingress in minikube cluster..."
minikube addons enable ingress
ingress_namespace=ingress-nginx
# Expose node app from outside from the cluster with ingress controller
kubectl patch configmap tcp-services -n ${ingress_namespace} --patch '{"data":{"8081":"default/app:8081"}}'
kubectl patch deployment ingress-nginx-controller --patch "$(cat ../charts/ingress-controller-merge-ports.yaml)" -n ${ingress_namespace}
# Configure minikube to working with local images 
else
    echo "minikube already installed"
fi

