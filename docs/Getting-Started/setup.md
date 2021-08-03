# Steps

Utility Script [setupEnv.sh](../../../hack/setupEnv.sh)

## 1. Kind

Create a kind cluster with the follwoing config

```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: metis
nodes:
  - role: control-plane
     kubeadmConfigPatches:
      - |
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
      extraPortMappings:
      - containerPort: 80
        hostPort: 8111
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP
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
kind delete  cluster --name metis
kind create cluster --config kind-config.yaml
kubectx kind-metis
kubectl create namespace argocd
kubectl apply -n argocd -f "https://raw.githubusercontent.com/argoproj-labs/applicationset/master/manifests/install-with-argo-cd.yaml"
```


## 3. Install Metis Helm Char as application
```
kubectl apply - charts-bootstrap/metis-appsets-applcaiton.yaml -n argocd

```



