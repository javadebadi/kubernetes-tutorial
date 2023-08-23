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



## Check Installation
To check that `minikube` has been installed successfully, we will run the following commands. Before, running this command make sure your runtime or hypervisor (such as Docker or VirtualBox) are running.
### Start Minikube
Run the following commands to start the `minikube` cluster
```bash
minikube start
```
<img width="1123" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/70c40029-be84-4a5e-adeb-39a66f03b7eb">

### Check Status of the Minikube
Run the following command and carefully investigate what you see in the screen:
```bash
minikube status
```
<img width="1127" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/e86f0bb8-86c4-4028-aa5f-1d20071ef9ec">

### Stop Minikube
Now, run the following command to stop the minikube
```bash
minikube stop
```
<img width="1125" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/febdec31-014b-4b64-ba8e-6f3093d08895">


