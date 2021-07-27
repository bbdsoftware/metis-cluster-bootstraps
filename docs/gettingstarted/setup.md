# Scripts


Utility Script [setupEnv.sh](../../../hack/setupEnv.sh)

# Steps

## 1. Kind

Create a kind cluster with the follwoing config

```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: metis
nodes:
  - role: control-plane
  - role: worker
    kubeadmConfigPatches:
      - |
        kind: JoinConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "role=add-ons-platform"
  - role: worker
    kubeadmConfigPatches:
      - |
        kind: JoinConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "role=add-ons-platform"

```

## 2. Install Argocd and Applcation Set controller

```
kubectx kind-kind
kubectl create namespace argocd
kubectl apply -n argocd -f "https://raw.githubusercontent.com/argoproj-labs/applicationset/master/manifests/install-with-argo-cd.yaml"
```


## 3. Install Metis Helm Char as application

```
helm3 template charts-bootstrap/metis-appsets | kubectl apply -n argocd -f -
```



