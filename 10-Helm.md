# Helm
Helm is a tool to manage resources in Kubernetes cluster. It is a DevOps tool.


Helm will take care of applying your changes to Kubernetes cluster automatically.

Helm uses a concept called charts to do these operations.

## Helm Hub
Inside the [Helm Hub](https://artifacthub.io/), a lot of charts for many different softwares are available. You can install those charts in you Kubernetes cluster.

You can search in the [Helm Hub](https://artifacthub.io/) website for softwares or solutions that you need and there is a high chance that the Helm chart for that software is already provided officially by the company and you can install and use it in your own Kubernetes cluster.

### Example
In this example, we will install a helm chart from Helm Hub.
We search for Wordpress and click on the chart maintained by bitnami company
<img width="1114" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/4a7c6cfd-4808-445a-b903-5bf5ce377f59">
If you click on the **install** button, it will show you commands to run in order to install this helm chart
<img width="1113" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/02ac8725-ed2d-4ae2-8d2f-59f980699eaa">

So, first we run the following command:
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```
<img width="896" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/e1947aa7-85db-474d-8c04-abaca1ba8c1e">

To check that repo is added run the following command:
```bash
helm repo list
```
<img width="898" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/d39fa761-5639-418a-b496-b266678336df">


Then we start the minikube cluster
```bash
minikube start
```

Next we create a namespace for Wordpress
```bash
kubect create namespace -name wordpress
```

<img width="883" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/53dbf51f-0f82-4a4f-adbf-46947f22a3a4">

and then we run following command to create wordpress pods in wordpress namesapce
```bash
helm install my-wordpress bitnami/wordpress --version 17.1.16 --namespace wordpress
```
<img width="900" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/e8015072-4b59-4596-be0b-40b264009565">

Now, we can get the pods in wordpress namespace:
```bash
kubectl get pods --namespace wordpress
```
<img width="877" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/0746a957-7f53-47cc-a5b3-077069b7254a">

Also we can check list of installed helm charts:
```bash
helm ls --namespace wordpress
```
<img width="899" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/02998218-048e-48a9-b6e1-c362ec8b9398">

