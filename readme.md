#### Fluffy Computing Machine

Who knew github had a random name generator? Will the wonders ever cease. This probably saved me an hour.

# Getting started:

This is tested on amazon linux 2:latest. Clone the repo and run the setup.sh script with root privs to get the instance set up, then run the cluster-setup.sh with root privs to set up the Kind cluster. I say tested: current result is failed, which is a valid test result. Most systems are now operational but the proxy isn't fully configured so they can't be hit directly.

### tl;dr

cd fluffy-computing-machine
sudo chmod +x=u instance-setup.sh
sudo chmod +x=u cluster-setup.sh

Should work on centos7-like systems.

Here are some helpful websites to get these services established:
- Set up [Kubernetes](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- Set up [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- Set up [elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html)
- Set up [kibana](https://www.elastic.co/guide/en/kibana/current/index.html)
- Set up [nginx](https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/)
