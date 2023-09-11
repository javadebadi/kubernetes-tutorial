# Pods
Kubernetes Pods are the smallest unit of workload in Kubernetes.  A Pod is a logical collection of one or more containers, enclosing and isolating them to have access to shared volumes and have same IP addresses.


## Example of a YAML File for Pod
Here is an example of a pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```

In this template, a pod with single container of nginx image is determined in a Kubernetes manifest yaml file.


## Run Application using Kubernetes Pods
Let's run an `nginx` application using Kuberentes Pods. In order to do that, first we run the minikube cluster using `minikube start`:
```bash
minikube start
```
<img width="1119" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/f490a5b3-88d8-4bdd-a7e3-88f8c6547ab8">

Then, lets create a yaml file named `08-nginx-pods-example.yaml` with the following content:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```
<img width="1123" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/d429188e-057e-44fe-be00-a0a3e0d285d8">


Then, with the following command, we can apply changes in this YAML file to the Kubernetes cluster using `kubectl apply -f <yaml-file-name.yaml>`.

```bash
kubectl apply -f 08-nginx-pods-example.yaml
```
<img width="1126" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/0cc87f76-7205-4c4f-97c4-ce1b4b3db976">

To get a list of pods in the cluster, we run the following commands:
```bash
kubectl get pods
```
<img width="1125" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/248e54b9-b5dd-451e-8af8-0ce7b241b268">

We see that a pods with name _nginx_ is _Running_ now.


To have a better view of the pod information, we can run the `kubectl get pods -o wide` command:
```bash
kubectl get pods -o wide
```
<img width="1122" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/96f4b5ca-6f6e-4086-96c9-a21ae30ce705">



### Run application using kubectl run
Another way to run a Pod is to use `kubect run <pod-name> --image=<image-name>`.
For example, to run a pod with latest version of _nginx_, we can run the following command:
```bash
kubectl run nginx-latest --image=nginx
```
<img width="1123" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/24531d48-b76e-4812-849d-98fecc253ace">

Now, if we check the pods in our cluster:
```bash
kubectl get pods -o wide
```
<img width="1122" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/5a22ce36-9886-4b48-8cc0-24c0cc48f216">
We see that ther are two pods named nginx and nginx-latest running in the cluster.


## Troubleshooting
When there is an error during running a Kubernetes Pod we can use the `kubectl describe pod <pod-name>` command and look at the event section in the printed output:
```bash
kubectl describe pod nginx
```
<img width="1920" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/aaf9c114-0bcc-413c-826d-eb5c659960ee">

In order to show how to use this troubleshooting tool, lets creat a copy of `08-nginx-pods-example.yaml` and rename it to `08-nginx-pods-example-2.yaml`. Then, insdie the file, change name of the pod (Kubernetes objects in each namespace should have unique names) to another name. In addition, let's change the image name from `nginx` to `nginxxxx` to create intentioanl erros and use troubleshooting to solve the problem. Thus, finally the `08-nginx-pods-example-2.yaml` file will have the following content:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginxxxx
spec:
  containers:
  - name: nginx
    image: nginxxxx:1.14.2
    ports:
    - containerPort: 80
```

Then we run the pod using:
```bash
kubectl apply -f 08-nginx-pods-example-2.yaml
```
<img width="1121" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/9390d50e-ac27-4918-8417-155f0a598023">

The pod is created successfully, however, if we look at the pods information we realize that the `nginxxxx` pods is not running:
```bash
kubectl get pods -o wide
```
<img width="1121" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/8974bab5-0cdf-436b-825a-8a6fba88b573">
In addition, we see that the status of this pod is `ErrImagePull`. The status is descriptive enough, but let's see the events section of the describe command:
```
kubectl describe pd nginxxxx
```
<img width="1920" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/eceb1d7b-439e-409b-b8b9-5bec6d5643d5">

As we see, there is a message stating that "Failed to pull image "nginxxxx:1.14.2"". So, lets correct the yaml file and replace the pod. The content of the `08-nginx-pods-example-2.yaml` is corrected as follows:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginxxxx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```
To replace the 'nginxxxx' pod we run the following:
```bash
kubectl replace --force -f 08-nginx-pods-example-2.yaml`
```

<img width="1123" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/1609f2b5-feb4-48d9-a485-54de2e063362">

Now, let's check the pods information:
```bash
kubectl get pods -o wide
```

<img width="1123" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/c0411b4e-2a7e-4d59-9909-8f73defeda57">


## Delete pods
To delete a pod we run the command `kubectl delete pod <pod(s)-name>`:

```bash
kubectl delete pod nginx-latest nginxxxx
```

<img width="1122" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/6eb118d9-ba8f-4cfd-ac03-6d095434d410">

We see that the 'nginx-latest' and 'nginxxxx` pods are deleted.

The other way to delete a pod is by using the yaml file that we used to run the pod `kubectl delete -f <yaml-file-name>

```bash
kubectl delete -f 08-nginx-pods-example.yaml
```
<img width="1124" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/4c096f7e-01e2-493a-b370-94afc0d36e1b">

We can validate that no pods are running:
```bash
kubect get pods
```
<img width="1124" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/024681b3-c678-4cba-bd3f-1000f44b518c">













