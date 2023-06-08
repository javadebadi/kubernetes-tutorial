# Installation

To learn Kubernetes you need to install docker and minikube in your computer.
There are lot of reference that you can learn docker and how to install it.
To install minikue click [here](https://minikube.sigs.k8s.io/docs/start/). You can choose your OS, download minikube and the install it.
I had a MacOS with M2 chip and I download the minikube for ARM64 architecture and thank God it worked :).

<img width="1125" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/fd39efb8-35a0-48a3-a786-a6992e4ceaf7">

As shown in the image to test your installation run this command:
```bash
minikube start
```
and then to interact with you Kubernetes cluster
```bash
kubectl get po -A
```
