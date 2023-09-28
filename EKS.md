# EKS
Amazon has managed a Kubernetes service called **Elastic Kubernetes Services (EKS)**. EKS is a managed service and you don't have access to control plane nodes, but you have access to your worker nodes and you can deploy your pods in EKS.
In this tutorial, we show you how to use EKS to create a cluster and deploy your applications.

## Create Cluster
To create a cluster we need to have a `cluster.yaml` config file first.
A simple example of yaml file is given here:
https://github.com/eksctl-io/eksctl/blob/main/examples/01-simple-cluster.yaml

Based on this example we create the following yaml file:
```yaml
# A simple example of a ClusterConfig object:
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: eks-tutorial-cluster
  region: ca-central-1
  tags:
    project: eks-tutorial

nodeGroups:
  - name: ng-1
    instanceType: t2.micro
    desiredCapacity: 1

```

### Create Cluster
To create an EKS cluster we run the following command:
```bash
eksctl create cluster -f cluster.yaml
```
After you run this command, you may see that the process takes a long time. In particular, I was viewing `waiting for CloudFormation stack "eksctl-eks-tutorial-cluster-cluster" ` and I thought something had gone wrong. However, it is normal and the process takes about 20 minutes as mentioned [here](https://stackoverflow.com/questions/65756827/eksctl-create-cluster-stuck-waiting-for-cloudformation-stack).
<img width="1610" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/4478692f-fa6c-4279-8cc0-0a465eeab13b">

### Get the list of clusters
To view details of all clusters run the following command
```bash
eksctl get cluster
```
<img width="1608" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/d5d1b64a-6e37-4fdd-b68b-3b8ca83a45ba">

### Delete cluster
EKS cluster can be very expensive, so remember to delete the cluster as soon as you don't need it anymore.
To delete a cluster we run the following command:

```bash
eksctl delete cluster -f cluster.yaml
```
<img width="1610" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/8109fc68-9472-485f-bd9a-6865b0c8ae5f">
