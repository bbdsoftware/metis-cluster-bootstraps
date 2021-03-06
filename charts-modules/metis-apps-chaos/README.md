
Metis-apps-chaos
===========

A Helm chart child for chaos bootstrap

# APP of APPS Bootstrap for kube-chaos

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

## Helm Charts included as applications
 - powerfulseal   : https://github.com/powerfulseal/powerfulseal



```
## Configuration

The following table lists the configurable parameters of the Metis-apps-chaos chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `spec.powerfulseal.enabled` | install pwoerfulseal controller | `true` |
| `spec.chaosMesh.enabled` | install chaos mesh | `false` |
| `spec.aws.enabled` | enabled if running in aws eks | `true` |
| `spec.destination.clustername` |  | `"test"` |
| `spec.destination.server` | argocd registered server address | `"https://kubernetes.default.svc"` |
| `spec.destination.name` |  | `"test"` |
| `spec.destination.project` | argocd project name | `"kube-apps-chaos"` |
| `spec.source.repoURL` |  | `"https://github.com/bbdsoftware/metis-cluster-bootstraps.git"` |
| `spec.source.customChartPath` |  | `"charts-modules/metis-apps-chaos/custom-charts/"` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._

