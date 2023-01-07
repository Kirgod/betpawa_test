BetPawa test task
---------------------

### Content  
- [Overview](#headers)  
- [Run locally with minikube](#headers)  
- [Run in existing k8s cluster](#headers)
- [What should (not) be done in real project](#headers)

<a name="headers"><h2>Overview</h2></a>
Simple app on Flask, which add some text to DB and shows it.


<a name="headers"><h2>Run locally with minikube</h2></a>
For local run just start ```minikube_init.sh``` script which will do following steps:
- Check minikube/docker are exists
- Start minikube
- Build docker image in minikube
- Apply all manifest files
- Do port forwarding to app service
- Open browser with app

Requirments:
- docker
- minikube
- kubernetes

Usage:
```
. minikube_init.sh
```


<a name="headers"><h2>Run in existing k8s cluster</h2></a>
- Build Docker image and push to docker repository.
- Change image name in ```kubernetes/app.yaml``` file (Line: 20).
- Change ```USER```, ```KUBE_CONFIG```, ```NAMESPACE``` and run following command:
```
kubectl --kubeconfig /home/USER/.kube/KUBE_CINFIG -n NAMESPACE apply -f kubernetes/
```

<a name="headers"><h2>What should (not) be done in real project</h2></a>
- Secrets storing should be encrypted. Example: Sealed Secrets
- Processes in container should not run as root
- Add liveness/readiness probes
- Quotas
- Network policies
- Proper ingress
- Proper CICD (including structure of project, varaibles, environments, etc.)
