# Kubernetes configuration

This repository contains K8s configuration for nginx / php-fpm applications that aren't just APIs! A shared volume is used to mount static files (js, css, etc) on both nginx and fpm containers, so that you can use this setup for a full website.

It also includes nginx as an ingress controller, to save costs on GKE (as their HTTP Load Balancer isn't so cheap).

The setup looks as follows:

```
$ kubectl get deployment
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
php-app   1         1         1            1           33m

$ kubectl get daemonset
NAME      DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
ingress   3         3         3         3            3           <none>          26m

$ kubectl get configmap
NAME           DATA      AGE
ingress-conf   1         1h
nginx-config   1         52m

$ kubectl get service
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
kubernetes   ClusterIP   10.11.240.1    <none>        443/TCP    7h
php-app      ClusterIP   10.11.249.39   <none>        8080/TCP   35m

$ kubectl get pod
NAME                       READY     STATUS    RESTARTS   AGE
ingress-2b6sq              1/1       Running   0          26m
ingress-878km              1/1       Running   0          26m
ingress-t8gwq              1/1       Running   0          26m
php-app-55648d549c-drqk5   2/2       Running   0          8m
```

## Usage

- Change the name of the container, as this is referencing one of mine and it won't work for you!
- Build the container and push it to gcloud - see [here][1] for info
- `kubectl apply -f kubernetes-config/`

### Acknowledgements

Thanks to [Caleb Doxsey's blog post][1] and [Matthew Palmer's blog post][2] for helping me piece this together.


[1]: http://www.doxsey.net/blog/kubernetes--the-surprisingly-affordable-platform-for-personal-projects
[2]: https://matthewpalmer.net/kubernetes-app-developer/articles/php-fpm-nginx-kubernetes.html
