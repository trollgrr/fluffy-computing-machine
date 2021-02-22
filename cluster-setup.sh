#!/bin/bash
kind delete cluster
kind create cluster --config=./kind-config.yaml
sudo kubectl create -f proxy/nginx_svc.yaml
kubectl create configmap nginx-map -f ./config/nginx.conf
sudo kubectl create -f proxy/nginx.yaml
sudo kubectl create -f elasticsearch/e_svc.yaml
sudo kubectl create -f elasticsearch/elastic.yaml
sudo kubectl create -f kibana/kibana.yaml
