kubectl create namespace crossplane-system
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm upgrade crossplane --namespace crossplane-system crossplane-stable/crossplane --version 1.3.1 --install


echo "Waiting on crosplane installs.."
kubectl  wait --for condition=established --timeout=60s crd/providers.pkg.crossplane.io
helm upgrade --namespace crossplane-system metis ./metis-crossplane-bootstrap --install

echo "Waiting on providers installs.."
kubectl  wait --for condition=established --timeout=60s crd/providerconfigs.helm.crossplane.io
kubectl  wait --for condition=established --timeout=60s crd/providerconfigs.kubernetes.crossplane.io
helm upgrade --namespace crossplane-system metis-config ./metis-crossplane-bootstrap-config --install


SA=$(kubectl -n crossplane-system get sa -o name | grep provider-kubernetes | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding provider-kubernetes-admin-binding --clusterrole cluster-admin --serviceaccount="${SA}"

SA=$(kubectl -n crossplane-system get sa -o name | grep provider-helm | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding provider-helm-admin-binding --clusterrole cluster-admin --serviceaccount="${SA}"

echo "Avßailable metis CRDS..."
kubectl get crds | grep metis