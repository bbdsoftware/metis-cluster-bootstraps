
Metis-apps-storage
===========

A Helm chart child for addon bootstrap of straoge

# APP of APPS Bootstrap for kube-storage

This chart contains all argo applications that would be deployed into the kube-addons namespace to provide for various
capabilities

## Structure

### **Tempaltes:**


- **Argo Applications**

    This folder contains the argo applications that would be deployed as part of kube-addons bootstraps

- **ArgoConfig**

    This contains the project definitions  for the argo project
    This  contains the argo definitions for the namespaces kube-addons

- **RBAC**

    This contains the rbac configs for the kube-addons ns

## Development
### Linting
To run the linting test a util script called helmLint.sh has been provided to run the ct tests via a docker container




```
## Configuration

The following table lists the configurable parameters of the Metis-apps-storage chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `spec.appName.enabled` |  | `true` |
| `spec.aws.enabled` | enabled if running in aws eks | `true` |
| `spec.destination.clustername` |  | `"test"` |
| `spec.destination.server` | agocd registered server address | `"https://kubernetes.default.svc"` |
| `spec.destination.name` |  | `"test"` |
| `spec.destination.project` | agocd project name | `"kube-apps-storage"` |
| `spec.destination.syncPolicy` |  | `null` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

