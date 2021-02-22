#!/bin/bash
# This should get your cluster configured and deployed, or at least tell you where it went wrong
kind delete cluster
if kind create cluster --config=./kind-config.yaml ; then
	echo "Cluster created"
else
	echo "Cluster failed. Sorry, but check the instance setup script."
	exit 1
fi

if kubectl create -f ./proxy/n_svc.yaml ; then
	echo "Proxy Service Configured."
else
	echo "Proxy Service failed."
	kubectl delete service nginx
	exit 1
fi

if kubectl create configmap nginx-map --from-file=./proxy/config/nginx.conf ; then
	echo "Config Map Configged."
else
	echo "Config Map Conflagration."
	kubectl delete configmap nginx-map
	exit 1
fi
if kubectl create -f proxy/nginx.yaml ; then
	echo "Proxy Created"
else
	echo "Proxy Failed!"
	kubectl delete pods nginx
	exit 1
fi

if kubectl create -f elasticsearch/e_svc.yaml ; then
	echo "ElasticService Created"
else
	echo "Inelastic services only. Better luck next time."
	kubectl delete service elasticsearch
	exit 1
fi
if kubectl create -f elasticsearch/elastic.yaml ; then
	echo "Elastic Pods Created"
else
	kubectl delete pods es-cluster
	echo "Elastic Pods failed."
	exit 1

if kubectl create -f kibana/kibana.yaml ; then
	kubectl delete pods kibana
	echo "kibana failed"
	exit 1
