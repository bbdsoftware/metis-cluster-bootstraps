# APP of APPS Bootstrap for kube-addons

This char contains all argo applications that would be deployed into the metis-apps-crossplane namespace to provide for various
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



