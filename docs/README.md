
# Introduction
See [official documentation](https://bbdsoftware.github.io/metis-cluster-bootstraps/)

# Introduction
Cluster bootstraps for GitOps based on argocd.

# PreRequisites
- K8 cluster eg [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- Installed [kubectl](https://kubernetes.io/docs/tasks/tools/) command-line tool
- Installed kubectl [krew](https://krew.sigs.k8s.io/docs/user-guide/setup/install/) package manager
- Installed [kubectx](https://github.com/ahmetb/kubectx) power tools for kubectl
- Installed [helm3](https://helm.sh/docs/intro/install/)
- Installed [Argo + Argo ApplicationSets controller](https://argocd-applicationset.readthedocs.io/en/stable/Geting-Started/)


# Repo Structure

There are two folders each containing helm charts used for installing various argocd CRDs.

##charts-modules
These are a collection  of Helm  Charts organised as "modules". Each chart module is a collection of argo applications, ArgoCD config and namespaces config for various related addons , operator and kubernetes worklaods.

see [Chart Modules](charts/modules/main.md)


## charts-bootstrap

## metis appliciation sets

The metis appset chart contains a collection of argo [applicationsets](https://argoproj.github.io/argo-cd/user-guide/application-set/)

The metis argo applications sets will generate argo applications based of the helm charts in this repo.


# Contributing
See  [official documentation](http://127.0.0.1:8000/Contributing/AddingApplications/)