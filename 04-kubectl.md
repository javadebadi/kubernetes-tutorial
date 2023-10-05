# Access Kubernetes Cluster Using Kubectl

One way to access and manage a Kubernetes cluster is by using a CLI tool called `kubectl`.

There are other CLI tools for Kubernetes:
- `kubie`
- `k9s`
After getting familiar with `kubectl` and Kubernetes you can try this CLI tools which can increase your productivity in terminal.

## Install Kubectl
To install `kubectl` in MacOS do the following:
```bash
sudo chown -R $(whoami) /opt/homebrew
brew install kubernetes-cli
```

## Kubernetes Config
The `kubectl` is a client-side CLI tool to connect to the Kubernetes cluster. In order for `kubectl` to connect to a Kubernetes cluster, it has to know the cluster endpoint and the credentials to connect to the clusters. This information is stored in `~/.kube/config`.

Before starting a `minikube` cluster, let's look at the content of the `~/.kube/config` using `cat ~/.kube/config` command:
<img width="1120" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/fc44aa23-78a2-4fea-a371-1a0cb4e94e19">

We see that it is basically a set of null or empty values. Now, let's start the `minikube` cluster with `minikube start` and investigate content of this config file again.
<img width="1119" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/63ec71a2-ec2f-4f24-987a-191c357c0ea7">

Now, using `cat ~/.kube/config` command:
<img width="1120" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/237a0708-71e4-4012-bc86-be56102920a0">

As you see this config file has cluster endpoint `https://127.0.0.1:51147` and credentials to connect to the cluster `client-certificate: /Users/javad/.minikube/profiles/minikube/client.crt` and `client-key: /Users/javad/.minikube/profiles/minikube/client.key`. This information are added to the config file by the `minikube` automatically.

### Kubectl config command
The other way to view the kubectl config is to use the following command:
```bash
kubect config view
```
<img width="1118" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/45f6717b-b084-47d4-b363-3ef17a1e76bc">


## Cluster information
To find information about the `minikube` cluster using `kubectl` run the following command:
```bash
kubectl cluster-info
```
<img width="1107" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/1fc8275f-25f7-4a66-80b6-d5a1864abda7">
