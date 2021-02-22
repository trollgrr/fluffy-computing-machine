#### Fluffy Computing Machine

Who knew github had a random name generator? Will the wonders ever cease. This probably saved me an hour.

# Getting started:

This is tested on amazon linux 2:latest. Clone the repo and run the setup.sh script with root privs to get the instance set up, then run the cluster-setup.sh with root privs to set up the Kind cluster. I say tested: current result is failed, which is a valid test result. All systems are currently failing.

Here are some helpful websites to get these services established:
- Set up [Kubernetes](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- Set up [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- Set up [elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html)
- Set up [kibana](https://www.elastic.co/guide/en/kibana/current/index.html)
