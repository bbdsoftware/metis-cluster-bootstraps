
# Introduction
See  [official documentation](https://bbdsoftware.github.io/metis-cluster-bootstraps/)

# Introduction
Cluster bootstraps for GitOps based on argocd

# PreRequisites
- K8 clsuter eg [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- Installed [kubectl](https://kubernetes.io/docs/tasks/tools/) command-line tool
- Argo + Argo Applicationsets controller   [Install](https://argocd-applicationset.readthedocs.io/en/stable/Geting-Started/)


# Repo Structure

This repository is structured into folders containing helm charts.
Each chart is a collection of argo application crd definitions that related to the installation of toolsets and workloads

##charts-modules
These are a collection  of Helm  Charts organised as  "modules". Each chart module is a collection of argo applications. argocd config and namespaces config for various related addons , operator and kubernetes worklaods.

see [Chart Modules](charts/modules/main.md)


##charts-boostrap

## metis appliciation sets

The metis appset chart contains a collection of argo applications

The metis argo applications sets contain argo application sets that will , upon application into the cluster would result in the creation of various
argo application based on the folder structure and file directory pattern defined in the application set.


# WalkThrough
See  [official documentation](https://bbdsoftware.github.io/metis-cluster-bootstraps/charts/bootstrap/main/)