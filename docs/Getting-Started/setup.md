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
## 2. Boostrap Crossplane and Providers into cluster

```
sh charts-bootstrap/boostrap.sh
```

The above script till install crossplane and 2 metis charts

- metis-crossplane-bootstrap
  
  This chart will install the required crossplane providers namely proviider aws , provider kubernete and provider helm

- metis-crossplane-config

  This chart will install the provider configs for the installe providers.


## 3. Initiate a metis bootstrap
```
kubectl apply -f charts-bootstrap/boostrap.yaml
```

This will intial the bootstrap from the metis crossplane XRD that should now be installed in the cluster in
step 2




