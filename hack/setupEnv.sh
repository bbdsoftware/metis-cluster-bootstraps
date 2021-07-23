kind create cluster --config kind-config.yaml
kubectx kind-kind
kubectl create namespace argocd
kubectl apply -n argocd -f "https://raw.githubusercontent.com/argoproj-labs/applicationset/master/manifests/install-with-argo-cd.yaml"