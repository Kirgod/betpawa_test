#!/bin/bash

echo 'Checking that minikube is installed...'
if minikube version; then
    echo 'Minikube OK...'
else
    echo 'ERROR: Minikube not detected...'
    return 1
fi
echo '------------------------------------------'

echo 'Checking that docker is installed...'
if docker --version; then
    echo 'Docker OK...'
else
    echo 'ERROR: Docker not detected...'
    return 1
fi
echo '------------------------------------------'

echo 'Starting minikube with driver docker...'
minikube start --driver=docker
echo '------------------------------------------'

echo 'Get vars to build image inside of minikube...'
eval $(minikube -p minikube docker-env)
echo '------------------------------------------'

echo 'Building docker image...'
docker build -t app/app .
echo '------------------------------------------'

echo 'Apply all kubernetes objects...'
kubectl apply -f kubernetes/
echo '------------------------------------------'

echo 'Waiting resources...'
sleep 100
while true
  do 
    running_pods=$(kubectl get pods | grep app-deployment | grep 1/1 | wc -l)
    if [ "$running_pods" -gt 0 ]
    then
        echo "Pod is up, continue..."
        break
    else
        echo "Waiting..."
        sleep 20
    fi
  done
echo '------------------------------------------'

echo 'Opening browser with localhost'
xdg-open http://localhost:8080/
echo '------------------------------------------'

echo 'Forwarding port to kubernetes svc...'
kubectl port-forward service/app-deployment-svc 8080:8080
echo '------------------------------------------'