---
title: "Kubernetes"
date: 2018-06-27
categories: [DevOps]
tags: [kubernetes, k8s]
---

Components
----------

![](/kubernetes.png)

Configuration
-------------

```bash
cat ~/.kube/config
# or
kubectl config view
```

Namespace
---------

* group of objects in a cluster
* similar to a filesystem folder

```bash
kubectl get namespaces
```

Context
-------

* to change the default namespace more permanently
* to manage different clusters
* to manage different users

```bash
# list contexts
kubectl config get-contexts

# switch context
kubectl config use-context <context-name>
```

Objects
-------

* everything in Kubernetes is represented by a RESTful resource (a.k.a. a Kubernetes object)
* each object exists at a unique HTTP path, e.g. `https://your-k8s.com/api/v1/namespaces/default/pods/my-pod`
* the `kubectl` makes requests to these URLs to access the objects

```bash
# view Kubernetes objects
kubectl get all [-l app=nginx]    # all resources [with a label app=nginx]
kubectl get <resource>            # all resources in a namespace
kubectl get <resource> <object>   # specific resource

# details about an object
kubectl describe <resource> <object>

# output flags
-o wide       # more details
-o json       # complete object in JSON format
-o yaml       # complete object in YAML format
--v=6         # verbosity
--no-headers

# create, update objects
kubectl apply -f obj.yaml

# delete objects
kubectl delete -f obj.yaml  # no additional prompting!

# delete objects
kubectl delete <resource> <object>

# cleanup
kubectl delete deployments --all [--selector="app=myapp,env=dev"]

# debugging
kubectl logs <pod>
kubectl exec -it <pod> -- bash  # or sh instead of bash
kubectl cp <pod>:/path/to/remote/file /path/to/local/file
```

Pod
---

* atomic unit of work in Kubernetes cluster
* Pod = one or more containers working together symbiotically
* all containers in a Pod always land on the same machine
* each container runs its own cgroup but they *share* network, hostname and filesystem
* like a logical host
* if you want to persist data across multiple instances of a Pod, you need to use `PersistentVolumes`

Pod *manifest* - just a text-file representation of the Kubernetes API object:

```bash
kubectl apply -f quotes-pod.yml
```

Port forwarding:

```bash
kubectl port-forward quotes 5000:5000
```

What goes into a pod?

* Will these containers work correctly if they land on different machines?
* should go into a Pod: web server + git scynhronizer - they communicate via
    filesystem
* should go into separate Pods: Wordpress + DB - can communicate over net

Deployment
----------

* object of type controller
* manages replicasets/pods

One way to create a deployment:

```bash
kubectl create deployment quotes-dev --image=reisinge/quotes
kubectl scale deployment quotes-dev --replicas=3
kubectl label deployment quotes-dev ver=1 env=dev
```

Service
-------

* object that solves the service discovery problem (i.e. finding things in K8s cluster)
* a way to create a named label selector (`--selector`) - see `kubectl get service -o wide`
* a service is assigned a VIP called a *cluster IP* -> load balanced across all
    the pods identified by the selector

One way to create a service:

```bash
kubectl expose deployment quotes-prod
```

Looking beyond the cluster
--------------------------

* exposing services outside of the cluster

NodePorts

* it enhances a service (see above)
* in addition to a cluster IP, a service gets a port (user defined or picked by
    the system)
* every node in the cluster forwards traffic to that port to the service

Resources
---------

* [Kubernetes: Up and Running](https://www.safaribooksonline.com/library/view/kubernetes-up-and/9781491935668/) (2017)
* [Getting Started with Kubernetes](https://www.safaribooksonline.com/videos/getting-started-with/9780135237823) (video, 2018)
