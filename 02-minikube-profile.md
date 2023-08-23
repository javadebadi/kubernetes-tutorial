# Minikube Profile

In the context of Minikube, a **profile** refers to a set of configuration settings and options that determine how a Minikube cluster is created and behaves.
When `minikube start` is run without any arguments default profile named **minikube** will be created. To check the profile we can run the `minikube profile list` commands.


Let's start the minikube and check the profile:
1. Run `minikube start`
<img width="1120" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/754edc66-8c0d-4b70-9d3b-679cd01d12a7">
2. Run `minikube profile list` to see information about the default profile
<img width="1123" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/488e2901-5576-4734-86b1-2c6cba1a8cc4">

Your result may be different from this. Note all the information you see in this table. The port 8443 is the port in which Kubernetes API Server is running and we can communicate with the Kubernetes cluster using this API.
In addition, note that the number of **Nodes** is *1* and the **status** is *running*. Also, pay attention to the start in the **Active** column.



## Create Profile
We can create other profiles by providing arguments to `minikube start` assuming that the host OS has enough resources:

```bash
minikube start --driver=docker --kubernetes-version=v1.25.1 --cpus=6 --memory=4g -n 3  -p devbox
```
The `-p` argument determines name of the new profile.
Note that the if the version of the Kubernetes is different from latest, if will download the give version (in this case 1.25.1) and then it will add the profile.
<img width="1120" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/f39ef398-4c97-4b37-bdd5-0d3adc79c70f">

Now, let's check the list of profiles with the following command:

```bash
minikube profile list
```
<img width="1124" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/1e0500fe-d521-4d8f-be05-aa8be838262c">

Look at the **Active** column in the table, which profile has star?
Now, we have two profiles but one of them is active. We can change the active clusters to other profile. Only the active Minikube cluster (associated with the currently selected profile) consumes hardware resources on your local machine.


## Change Profile
We can change the active profile by using `minikube profile <profile_name>`. In this case run the following command:
```bash
minikube profile devbox
```
<img width="1121" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/a3b1038f-b238-40c9-8a7a-8e20a877db36">


Now run the `minikube profile list` again and compare the table with previous one:
<img width="1121" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/3e56bdc0-7eb3-4f0e-8469-6b7de665dffb">


To change the profile back to default run:

```bash
minikube profile default
```


## Delete Profile
To delete the profile use `minikube delete --profile <profile_name>`. In this case, run the following command:
```bash
minikube delete --profile devbox
```

<img width="1125" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/825a7aa9-0a80-427b-a618-8aaa6b4cde2a">





