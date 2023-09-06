# Kubernetes API

On other way to access Kubernetes cluster is using the API for programmtic access.

## Enable Servcie
First, `kubectl` can be used to communicate with Kubernetes API for authenticatation and makes service available. To do this we should run the command `kubectl proxy &`.
```bash
kubectl proxy &
```
<img width="1119" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/7ba20da1-0692-4a88-ae9e-c06a05fa3d39">

Now, we can use the endpoint `127.0.0.1:8001` to communicate with Kubernetes cluster programmtically.

## Access Kubernetes using API
Let's start by sending a GET request to this endpoint:
```bash
curl 127.0.0.1:8001
```
<img width="1123" alt="image" src="https://github.com/javadebadi/kubernetes-tutorial/assets/21107499/0f0aec21-9c2c-4478-b350-24ddca244414">

Here we see list of different endpoints that we can send other requests.

