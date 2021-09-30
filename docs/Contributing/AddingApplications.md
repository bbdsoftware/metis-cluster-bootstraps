# Adding a argo application to a module

# Steps

1. Identify the module to which the argo application will be added
2. Create a GitHub issue    
3. Create the application manifest under the application templates for the modulue
4. Application names should be suffixed with the values clustername
```
  
  metadata:
    name: gatekeeper-{{ .Values.spec.destination.clustername }}
    namespace: argocd

```
      
5. Manifest should be wrapped in an enabled flag

```
{{ if .Values.spec.gatekeeper.enabled -}}
apiVersion: argoproj.io/v1alpha1
kind: Application
....
{{- end }}
```
      
6. The argo project and namespace should be derived from the charts values

```
    ....
    destination:
        namespace:  {{ .Values.spec.destination.project }}
        server: {{ .Values.spec.destination.server }}
        project: {{ .Values.spec.destination.project }}

    ....
```
7. Run Lint test
    
```
    docker run -it --rm --name ct --volume $(pwd):/data quay.io/helmpack/chart-testing:latest sh -c "ct lint --config /data/ct-local.yaml --all --debug ".
```
8. PR the branch with reference to the issue from step 2   