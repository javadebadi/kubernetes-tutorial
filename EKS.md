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
  name: cluster-1
  region: ca-central-1
  tag:
    project: eks-tutorial

nodeGroups:
  - name: ng-1
    instanceType: t2.micro
    desiredCapacity: 1

```
