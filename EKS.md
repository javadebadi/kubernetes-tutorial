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


To create EKS cluster we run the following command:
```bash
eksctl create cluster -f cluster.yaml
```
After you run this command, you may see that the process takes long time. In particular, I was viewing `waiting for CloudFormation stack "eksctl-eks-tutorial-cluster-cluster" ` and I was thinking something has went wrong. However, it is normal and the processes takes about 20 minutes as mentioned [here](https://stackoverflow.com/questions/65756827/eksctl-create-cluster-stuck-waiting-for-cloudformation-stack).

To view details of all clusters run the following command
```bash
eksctl get cluster
```

To delete a cluster we run the following command:

```bash
eksctl delete cluster -f cluster.yaml
```