#!/bin/bash
# This should get your cluster configured and deployed, or at least tell you where it went wrong
kind delete cluster
rm -rf proxy/nginx
git rm -r --cached proxy/nginx
git submodule add --force https://github.com/nginxinc/kubernetes-ingress/ proxy/nginx
git -C proxy/nginx checkout v1.10.0

if kind create cluster --config=./kind-config.yaml ; then
	echo "Cluster created"
else
	echo "Cluster failed. Sorry, but check the instance setup script."
        kind delete cluster
	exit 1
fi

kubectl apply -f proxy/nginx/deployments/common/ns-and-sa.yaml
kubectl apply -f proxy/nginx/deployments/rbac/rbac.yaml
kubectl apply -f proxy/nginx/deployments/common/default-server-secret.yaml
kubectl apply -f proxy/nginx/deployments/common/ingress-class.yaml
kubectl apply -f proxy/nginx/deployments/common/crds/k8s.nginx.org_virtualservers.yaml
kubectl apply -f proxy/nginx/deployments/deployment/nginx-ingress.yaml
echo "ingress should be starting, give it a tick to get ready"
sleep 10
kubectl get pods --namespace=nginx-ingress
kubectl create -f proxy/nginx/deployments/service/nodeport.yaml
echo "To access the Ingress controller, use an IP address of any node of the cluster along with the two allocated ports."
kubectl create -f virtual.yaml
if kubectl create -f fluffy.yaml ; then
	echo "Namespace Created."
else
	echo "Namespace probably already exists. Lets just see how things go."
fi

echo "lets wait a tick for cluster pods to spin up"
sleep 10
echo "should be good enough"

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
fi

if kubectl create -f kibana/k_svc.yaml ; then
	echo "Made the Kibana service"
else
	kubectl delete service kibana
	echo "kibana service failed"
	exit 1
fi
if kubectl create -f kibana/kibana.yaml ; then
	echo "Success!"
else
	kubectl delete pods kibana
	echo "kibana failed"
	exit 1
fi
kubectl rollout status sts/es-cluster --namespace=fluffy
kubectl rollout status deployment/kibana --namespace=fluffy
sleep 10
kubectl describe pods --namespace=fluffy

echo "You've reached the end of this script. I can help you no further."
