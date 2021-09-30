
# Helm chart Modules

The cluster bootstraps are centered around the concept of a module.
Each module is effectively a helm chart templating out a collection of argo-applications.

Each application is a reference to the installation and configuration of a workload, commonly a community helm chart.
These applcaitons result in the deployment of these workloads to the cluster to provide capabilities

# Applications
Each application in a module is retailed in terms of the common capability they offer

Eg the **metis-apps-logging** module chart would deploy various argo applications related to logging and log collection
  - fleuntd-cloudwatch 
    
      For shipping logs to cloud watch
    
  - Logging-operator
    
      Operator to allow for the provisioning and deployment of EFK stacks
    
  - Promtial
    
      Log parser and shipper for loki log collection.

# Config
  Each module will, along with applications, set up an argo project and corresponding namespace.
  This is so that each module can be controlled and restricted using argo project settings and RBAC or OICD for example
 


