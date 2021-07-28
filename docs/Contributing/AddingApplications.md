# Adding a argo application to a module

# Steps

- Identify the module tow ich the argo application will be added
- Create a GitHub issue    
- Create the application manifest under the application templates for the moduel
- Application names should be suffixed with the values clustername
```
  
  metadata:
    name: gatekeeper-{{ .Values.spec.destination.clustername }}
    namespace: argocd

```
      
- Manifest should be wrapped in an enabled flag

```
{{ if .Values.spec.gatekeeper.enabled -}}
apiVersion: argoproj.io/v1alpha1
kind: Application
....
{{- end }}
```
      
- The argo project and namespace should be derived from the charts values

```
    ....
    destination:
        namespace:  {{ .Values.spec.destination.project }}
        server: {{ .Values.spec.destination.server }}
        project: {{ .Values.spec.destination.project }}

    ....
```
- Run Lint test
    script aviable at test.sh
    
```
    docker run -it --rm --name ct --volume $(pwd):/data quay.io/helmpack/chart-testing:latest sh -c "ct lint --config /data/ct-local.yaml --all --debug ".
```
 - PR the branch with reference to the issue from step 2   