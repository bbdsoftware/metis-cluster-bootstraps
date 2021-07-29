
Metis-apps-oam
===========

This is the description


# APP of APPS Bootstrap for kube-oam

This char contains all argo applications that would be deployed into the kube-addons namespace to provide for various
capabilities

## Structure

### **Tempaltes:**


- **Argo Applications**

    This folder contains the argo applications that would be deployed as part of kube-addons bootstraps

- **ArgoConfig**

    This contains the project definitons  for the argo project
    This  contains the argo defintions for the namespaces kube-addons

- **RBAC**

    This contains the rbac configs for the kube-addons ns

## Development
### Linting
To run the linting test a util script called test.sh has been provided to run the ct tests via a docer container




```

## Configuration

The following table lists the configurable parameters of the Metis-apps-oam chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `spec.kubevela.enabled` |  | `true` |
| `spec.aws.enabled` |  | `true` |
| `spec.destination.clustername` |  | `"test"` |
| `spec.destination.server` |  | `"https://kubernetes.default.svc"` |
| `spec.destination.name` |  | `"test"` |
| `spec.destination.project` |  | `"vela-system"` |
| `spec.destination.syncPolicy` |  | `null` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._
