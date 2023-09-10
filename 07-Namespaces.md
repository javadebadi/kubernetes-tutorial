# Kubernetes Namespaces

Namespaces are a way to create virtual subclusters inside a same Kubernetes cluster. This useful for mutliple users, developers and teams to use a same Kubernetes cluster.


## Kubernetes Namespace Commands

Let's start the minikube default cluster by running `minikube start`:
<img width="1120" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/19bac135-2b5c-4e62-96b3-c2e7e2d6c78a">

To get list of namespaces we run the following command:
```bash
kubect get namespaces
```
<img width="1120" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/23945a24-4ffb-44f4-a084-041da5d02fae">

We see that there are five namespaces. The `default` namespace is the name where all objects created by developers will be associated with it, unless other namespaces is determined.
The `kube-system` namespaces is where Kubernetes system related objects are within it.


### Create a new namespace
To createa a new namespace we can run the command `kubectl create namespace <namespace-name>`.
For example, we run the following command now to create a namespace with name _new-namespace_.
```bash
kubectl create namespace new-namespace
```
<img width="1126" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/5336c626-2403-4049-b58e-18e7e4dbf305">

To check this new namespaces, let check list of all namespaces:
```bash
kubectl get namespaces
```
<img width="1123" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/5835a918-7ca3-42e3-a006-ea3938d3a611">

We see that the namespace named _new-namespace_ is now being created.


## Delete a namespace
To delete a namespace we run `kubectl delete namespace <namespace-name>`. In this case, we run
```bash
kubectl delete namespace new-namespace
```
<img width="1122" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/c997fd46-c068-487c-acd6-211bf0c8d030">



