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
<span id="create-cluster"></span>
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


## Deploy Application on EKS Cluster
In this section, we deploy the application on the cluster. First, create a cluster as we discussed in <a href="#create-cluster">here</a> and then continue.
### Create Namespace
The first step is to create a namespace to organize resources for a project. The [./eks/namespace.yaml]("./eks/namespace.yaml") yaml file has the content for creating the namespace we want.
```yaml
kind: Namespace
apiVersion: v1
metadata:
  name: staging
```
Now, to create a namespace execute:
```bash
kubectl apply -f eks/namespace.yaml
```

### Create Deployment
The seconds step is to create the deployment yaml file for the application we want to deploy. For simplicity, we will deploy the nginx app which has a public
image in the Docker hub. The content of the file `./eks/deployment.yaml` is as follows:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: staging
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```
To create this deployment run the following command:
```bash
kubectl apply -f eks/deployment.yaml
```

### Create Services
The third step is to create service yaml file for the application. The content of the `./eks/service.yaml` file that we will apply is show in the below
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: staging
spec:
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP
  type: NodePort
  selector:
    app: nginx  
```
### Make Subnets of Cluster's VPC Accessible
[Inbound Access from Internet](https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html)
Here we want our application to be accessible from the Internet. In order to this, we need to add some tags to the VPC related to the cluster we have created.
Go to your AWS console, in the region you have created your cluster. Search for VPC in AWS console. Inside, VPC service page, filter list of VPC to show "eks-tutorial-cluster" VPC. In the below, I see the results for my AWS account:
<img width="1099" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/00814d56-26a8-4f1a-b604-2430cad2984b">

Click on the **Subnets** from the left menu bar and again filter for "eks-tutorial-cluster". You will see following subnets:
<img width="1096" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/f23d798e-93fe-46f2-899e-37d758880c77">

Here you see that there are 6 subnets and there is the word "private" in name of three of them and the other three subnet has the word "public". We should add tags to these clusters based on their name, i.e, based on whether they are private or public.

- Tag for private subnets:
  - Key: kubernetes.io/role/internal-elb
  - Value: 1
  - Key: kubernetes.io/cluster/eks-tutorial-cluster
  - Value: shared

- Tag for public subnets:
  - Key: kubernetes.io/role/elb
  - Value: 1
  - Key: kubernetes.io/cluster/eks-tutorial-cluster
  - Value: shared

Note that, if your subnet already has the necessary tag, you don't need to do this step. In my cluster, one of the tags was already there but you may need to do this manually if it is not there. I only needed to add the other tag. The tags automatically created for me was like this:
<img width="1096" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/0c543ecd-10d3-48f4-92c8-d79db6b8570d">
Then I added the tag `kubernetes.io/cluster/eks-tutorial-cluster: shared` to all of the private and public subnets.
<img width="1097" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/e3c0d330-11af-4bc8-8d38-fd5d5d0e77aa">



### Make Application Accessible on Internet
Use th guide in [AWS Load Balancer Controller](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html) for this step.

#### Create IAM Policy
In my case, first I download the `iam_plicy.json`:
```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json
```

Then I move the downloaded file to eks folder. Then, I create IAM policy using this command
```bash
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://eks/iam_policy.json
```

You will get similar response as follows:
```json
{
    "Policy": {
        "PolicyName": "AWSLoadBalancerControllerIAMPolicy",
        "PolicyId": "ANPAWCIJBWFHITCRXR2WZ",
        "Arn": "arn:aws:iam::417167683918:policy/AWSLoadBalancerControllerIAMPolicy",
        "Path": "/",
        "DefaultVersionId": "v1",
        "AttachmentCount": 0,
        "PermissionsBoundaryUsageCount": 0,
        "IsAttachable": true,
        "CreateDate": "2023-10-02T05:13:31+00:00",
        "UpdateDate": "2023-10-02T05:13:31+00:00"
    }
}
```
You will need the "Arn" value of this response later.

### Create IAM Role
First run this command to associate IAM OIDC provider with the cluster:
```bash
eksctl utils associate-iam-oidc-provider --region=ca-central-1 --cluster=eks-tutorial-cluster --approve
```

Then we create an IAM role with this policy attached and associate it with our EKS cluster.

```bash
eksctl create iamserviceaccount \
  --cluster=eks-tutorial-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::417167683918:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```


Check
```bash
kubect get sa -n kube-system
```



### Install Cert-manager
Cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates. When running web applications on EKS, you often need to secure the traffic with HTTPS. Cert-manager can automatically provision SSL/TLS certificates for your Ingress resources, ensuring that incoming traffic is encrypted.
Read [this document](https://cert-manager.io/docs/installation/) to see how to install certificate manager. To apply this on your Kubernetes cluster run the following command
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.1/cert-manager.yaml
```

```bash
kubectl get pods -n cert-manager
```

```bash
curl -Lo v2_5_4_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.5.4/v2_5_4_full.yaml
```

```bash
sed -i.bak -e '596,604d' ./v2_5_4_full.yaml
```

```bash
sed -i.bak -e 's|your-cluster-name|eks-tutorial-cluster|' ./v2_5_4_full.yaml
```

add arguments for region and vpc id in v2_5_4_full.yaml and run
```bash
kubectl apply -f eks/v2_5_4_full.yaml
```

```bash
curl -Lo v2_5_4_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.5.4/v2_5_4_ingclass.yaml

```

```bash
kubectl apply -f eks/v2_5_4_ingclass.yaml
```

Verify installtion
```bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```

### Ingress
```
kubectl apply -f eks/ingress.yaml
```

### Final Result
After this open load balancers in your AWS console and see the DNS for the application load balancer you created. You should see the following
<img width="774" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/df1b608f-cff7-4a2c-b63f-af9246ee1fff">
