# Kubernetes Dashboard

The other way to interact with Kubernetes cluster is using Kubernetes Dashboard, a graphical user interfaces (UI) to view status of the Kubernetes.

In order to view the Kubernetes Dashbaord in `minikube` we first need to enable dashboard addons.


## Enable Kubernetes Dashboard
To review the Minkikube addons use the following command:
```bash
minikube addons list
```
<img width="895" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/e8c8f30e-b195-40a3-b35d-a8779cd68ae3">

We see that the `default-storageclass` and `storage-provisioner` addons are enabled but others are disabled. We have to enable `metrics-server` and `dashboard` addons to view Kubernetes dashbaord.
In order to enable an addon, execute the command `minikube addons enable <addon-name>`. In this case, we run the following two commands 
```bash
minikube addons enable metrics-server
```
<img width="879" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/e90dffe5-b5e2-4c53-a239-5c124650a749">

```bash
minikube addons enable dashboard
``
<img width="894" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/49599c65-e7f8-4c00-bb64-b1948a8fdb06">

Now, let's check the list of addons again:
```bash
minikube addons list
```
<img width="894" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/c295e7bc-e437-43a4-8802-4d9ba2bd001f">

## Run Kubernetes Dashboard
To view the Kubernetes dashbaord run the following command
```bash
minikube dashboard
```
It should open the dashboard in new browser tab. If it didn't run the following command the get the dashbaord url:
```bash
minikube dashboard --url
```
<img width="894" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/5fa5d0c6-32cb-4a1f-942b-9083e868df31">

In browser, you will see a dashboard similar to this one. Try spending some time exploring different tabs in this dashboard.
<img width="1512" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/dd4dfe0b-e58c-4c86-a535-64aca02cdbf4">



