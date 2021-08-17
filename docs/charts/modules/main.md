
# Helm chart Moduels

The cluster bootstraps are centered around the concept of a module.
Each module is effectively a helm chart templating out a collection of argo-applications.

Each application is a reference to the installation and configuration of a workload , commonly a community helm chart.
These applcaitons result int he deployment of these workloads to the cluster to provide for capabilities

# Applications
Each application in a model is retailed in terms of the common capability  they offer

Eg the **metis-apps-logging** model chart would deploy various argo applications related to logging and log collection
  - fleuntd-cloudwatch 
    
      For shipping logs to cloud wathc
    
  - Logging-operator
    
      Operator to allow for the provitioning and deployment of EFK stacks
    
  - Promtial
    
      Log parser and shipper for loki log collection.

# Config
  Each module will along with applications set up a argo project and corresponding namespace.
  This is so that each module can be controlled and restirected using argo project settings and RBAC or OICD for example
 


