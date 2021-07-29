
Metis-appsets
===========

Helm chart for the instellatiion of argo application sets that will bootrap argo applications into the cluster


## Installation

Install manifests
```
  helm template /charts-bootstrap/metis-appsets | kubectl delete -n argocd -f -
```

This chart will result in argo application sets being genreated into the cluster.
Each applicaiton set will be placed in the argocd namespace and resulst in the instealion of a a coresponfing helm "module" for
each cluster added to argocd for mangament.


see [Chart Modules](../../charts/modules/main.md)

## Configuration

The following table lists the configurable parameters of the Metis-appsets chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `spec.helmmodules.addons.enabled` | enabled the helm chart module for installation of default set of kubernetes addons and capabilities | `true` |
| `spec.helmmodules.addonsaws.enabled` | enabled the helm chart module for installation of aws eks spesfic worklaods eg alb ingress etc | `true` |
| `spec.helmmodules.logging.enabled` | enabled the helm chart module for installation of common logging statks eg ELK, LOKI etc | `true` |
| `spec.helmmodules.monitoring.enabled` | enabled the helm chart module for installation of standard monitoring stacks ie kube-promethues, blackbok exporter etc | `true` |
| `spec.helmmodules.dr.enabled` | enabled the helm chart module for installation of disaster recovery workloads and tools | `true` |
| `spec.helmmodules.crossplane.enabled` | enabled the helm chart module for installation of crossplane and providers | `true` |
| `spec.helmmodules.chaos.enabled` | enabled the helm chart module for choas workloads and config | `true` |
| `spec.helmmodules.storage.enabled` | enabled the helm chart module for storage workloads and config | `true` |
| `spec.aws.enabled` |  | `true` |
| `spec.destination.clustername` |  | `"test"` |
| `spec.destination.server` | agocd registered server address | `"https://kubernetes.default.svc"` |
| `spec.destination.project` | agocd project name | `"metis-chart"` |



---
_Documentation generated by [Frigate](https://frigate.readthedocs.io)._
