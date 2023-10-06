# Kubernetes

- [01-Installtion](01-installation.md)
- [02-minikube-profile](02-minikube-profile.md)
- [03-minikube-nodes](03-minikube-nodes.md)
- [04-kubectl](04-kubectl.md)
- [05-kubernetes-dashboard](05-kubernetes-dashboard.md)
- [06-kubernetes-API](06-kubernetes-API.md)
- [07-Namespaces](07-Namespaces.md)
- [08-Pods](08-pods.md)


## Managed Kubernetes Services
- [Elastic Kubernetes Services (EKS)](EKS.md)

## Tips
When we use `kubectl`, a command line tool to work with Kubernetes, we print a lot of information in yaml format in the terminal. To improve terminal content visually we recommend to install `pygments`:
```bash
pip install Pygments
```
Then, you can pipe your outputs as follows to have visually informative results on your terminal screen:
```bash
cat yourfile.yaml | pygmentize -l yaml
```
