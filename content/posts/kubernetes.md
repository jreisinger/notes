---
title: "Kubernetes"
date: 2018-06-27
categories: [DevOps]
tags: [kubernetes, k8s]
---

![](https://lh6.googleusercontent.com/obUWmfsfwjDiGHSJyKI4y4wgBrTLad31YXN_o_dNsmWg8802OJwrhx8_UE18zCwMuHoGRasG4RVejw=w1920-h1079)

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

```bash
kubectl get namespaces
```

Context
-------

* to change the default namespace more permanently
* to manage different clusters
* to manage different users

```bash
# show current context
kubectl config current-context

# list contexts
kubectl config get-contexts

# switch context
kubectl config use-context <context-name>
```

Objects
-------

* everything in Kubernetes is represented by a RESTful resource - [Kubernetes] object
* each object exists at a unique HTTP path, e.g. `https://your-k8s.com/api/v1/namespaces/default/pods/my-pod`
* the `kubectl` makes requests to these URLs to access the objects

```bash
# view Kubernetes objects
kubectl get                       # all resource types
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
kubectl delete deployments --all

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
* each container runs its own cgroup but they share network, UTS (hostname) and IP namespaces
* if you want to persist data across multiple instances of a Pod, you need to use `PersistentVolumes`

Pod *manifest* - just a text-file representation of the Kubernetes API object:

```bash
kubectl apply -f quotes-pod.yml
```

Port forwarding :cool:

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
* manages pods

One way to create a deployment:

```bash
kubectl run quotes-prod --image=reisinge/quotes \
--replicas=3 --port=5000 --labels="ver=1,app=quotes,env=prod"
```

Service
-------

* a way to create a named label selector - see `kubectl get service -o wide`
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

* Kubernetes: Up and Running (2017)
