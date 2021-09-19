
#kubectl create namespace crossplane-system --dry-run=client -o yaml | kubectl apply -f -
#helm repo add crossplane-stable https://charts.crossplane.io/stable
#helm repo update
helm upgrade crossplane --namespace crossplane-system crossplane-stable/crossplane --version 1.3.1 --install


echo "Waiting on crosplane installs.."
kubectl  wait --for condition=established --timeout=60s crd/providers.pkg.crossplane.io
helm upgrade --namespace crossplane-system metis ./metis-crossplane-bootstrap --install

echo "Waiting on providers installs.."
kubectl  wait --for condition=established --timeout=120s crd/providerconfigs.helm.crossplane.io
kubectl  wait --for condition=established --timeout=120s crd/providerconfigs.kubernetes.crossplane.io
helm upgrade --namespace crossplane-system metis-config ./metis-crossplane-bootstrap-config --install --set spec.aws.iamServiceAccounts.roleName=$IAM_ROLE_NAME --set spec.aws.iamServiceAccounts.accountId=$AWS_ACCOUNT_ID


SA=$(kubectl -n crossplane-system get sa -o name | grep provider-kubernetes | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding provider-kubernetes-admin-binding --clusterrole cluster-admin --serviceaccount="${SA}"

SA=$(kubectl -n crossplane-system get sa -o name | grep provider-helm | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding provider-helm-admin-binding --clusterrole cluster-admin --serviceaccount="${SA}"

kubectl apply -f boostrap.yaml


echo "Avßailable metis CRDS..."
kubectl get crds | grep metis