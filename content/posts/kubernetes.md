---
title: "Kubernetes"
date: 2018-06-27
categories: [DevOps]
tags: [kubernetes, k8s]
---

[x](https://drive.google.com/open?id=1jL-McYa87pPNICXQb9fhp91TZHHST-dX)

[x](https://drive.google.com/open?id=1jL-McYa87pPNICXQb9fhp91TZHHST-dX)

![x](https://www.draw.io/?lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=kubernetes.png#R7ZbBjpswEIafhmMjwAnJHjfJ7vbQSqvm0GPlxROwahhqTEj69B0vBkKgUqVFbQ97wvwztmf%2Bz1h4bJednzQv0s8oQHmhL84e23thGCzDiB5WuTTKJto0QqKlcEm9cJA%2FwYm%2BUyspoBwkGkRlZDEUY8xziM1A41pjPUw7ohruWvAERsIh5mqsfpXCpK6Lld%2FrH0Emabtz4LtIxttkJ5QpF1hfSezBYzuNaJpRdt6Bsua1vjTzHn8T7QrTkJs%2FmeB8P3FVud72UCi8ZHZ%2BU6G5tG1rrHIBdmbgsW2dSgOHgsc2WhNo0lKTKRdW%2FAXUM5bSSMxJi2lF0BQ4gTaSvPx0k%2FCCxmBGCVzJZHLGvQsYtHuNW3Xd23Q4X0mu9SfADIy%2BUIqLdhjcOQwj9173VFmrpddEN07k7iQl3dq92TRwfk97vx55%2F4W8p0YPQN5HivbaCnkaMIh%2BVPZobKlB88EZdU8ZCo6mj9IocU%2FVPB9fF2rVG65UFn058B8wFbxMuwM2B%2BDlDeC7CcDhFOBgBsDhCPAzipH73RXgXxvgD50vjcbvsEOFZN4%2BxxzehGPa%2FREkKq2wVWbnxF7ki6yMOSxihZVY0N1quMxBfytBn6Q9MdujVKqt0QuZ76%2Fv9tFMJNdDkiyIRiRXEyBZ9HaOq3eOs3Fk69U%2F4xi9c5yN43Lz175Heu1%2FiF5jV7%2BV7OEX)

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
