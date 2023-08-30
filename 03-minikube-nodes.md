# Minikube Nodes
Let's start another `minikube` cluster with the following command
```bash
minikube start --driver=docker --kubernetes-version=v1.25.1 --cpus=6 --memory=4g -n 3  -p devbox
```
<img width="1206" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/9a8c0dd2-c93a-44e6-b1d2-a29985127603">

Then start this cluster with this command
```bash
minikube start -p devbox
```
<img width="1204" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/299d041e-9fd0-42e6-a346-ace5d5ac2ae4">

## Get Nodes of a Cluster
To see list of nodes for a cluster we run `minikube node list -p <profile_name>`. The the `<profile_name>` is not given, the list of nodes of default cluster will be returned.
```bash
minikube node list -p devbox
```
<img width="1197" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/45a21caa-2d00-4ca6-8b27-1fe42a2c2f89">

### IP of the Control Plane Node
To see the ip of the control plane node of a cluster run `minikube ip -p devbox`
 ```bash
minikube ip -p devbox
```

<img width="1199" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/dd081ec4-6136-45e8-9e7e-3ee043951817">

### IP of the Worker Node
To see the ip of the workder nodes use the same command but with `-n` argument: `minikube ip -p <profile_name> -n <node_name>`

```bash
minikube ip -p devbox -n devbox-m02
```
<img width="1201" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/604df2ab-4bfe-4174-b35a-7b3b1726ceda">


## Delete the Profile
Run the following command to delete the cluster:
```bash
minikube delete -p devbox
```

<img width="1202" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/f5b59be0-dad4-44a3-8899-08bd47666253">




