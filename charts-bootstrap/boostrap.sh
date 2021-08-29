set -e

IAM_ROLE_NAME=metis-seed
AWS_ACCOUNT_ID=$1
CLUSTER=$2
SERVICE_ACCOUNT_NAMESPACE=crossplane-system
OIDC_PROVIDER=$(aws eks describe-cluster --name "$CLUSTER" --region eu-west-1  --query "cluster.identity.oidc.issuer" --output text | sed -e "s/^https:\/\///")

echo AWS_ACCOUNT_ID: $AWS_ACCOUNT_ID
echo IAM_ROLE_NAME: $IAM_ROLE_NAME
echo SERVICE_ACCOUNT_NAMESPACE : $SERVICE_ACCOUNT_NAMESPACE

read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Nn]$ ]]
then
    exit 0
fi

echo Creating IAM ROLE

cat > trust.json  <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${AWS_ACCOUNT_ID}:oidc-provider/${OIDC_PROVIDER}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "${OIDC_PROVIDER}:sub": "system:serviceaccount:${SERVICE_ACCOUNT_NAMESPACE}:provider-aws-*"
        }
      }
    }
  ]
}
EOF

aws iam detach-role-policy --role-name $IAM_ROLE_NAME --policy-arn=arn:aws:iam::aws:policy/AdministratorAccess
aws iam delete-role --role-name $IAM_ROLE_NAME
aws iam create-role --role-name $IAM_ROLE_NAME --assume-role-policy-document file://trust.json --description "IAM role for provider-aws"
aws iam attach-role-policy --role-name $IAM_ROLE_NAME --policy-arn=arn:aws:iam::aws:policy/AdministratorAccess
rm -rf trust.json


kubectl create namespace crossplane-system --dry-run=client -o yaml | kubectl apply -f -
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm upgrade crossplane --namespace crossplane-system crossplane-stable/crossplane --version 1.3.1 --install


echo "Waiting on crosplane installs.."
kubectl  wait --for condition=established --timeout=60s crd/providers.pkg.crossplane.io
helm upgrade --namespace crossplane-system metis ./metis-crossplane-bootstrap --install

echo "Waiting on providers installs.."
kubectl  wait --for condition=established --timeout=120s crd/providerconfigs.helm.crossplane.io
kubectl  wait --for condition=established --timeout=120s crd/providerconfigs.kubernetes.crossplane.io
helm upgrade --namespace crossplane-system metis-config ./metis-crossplane-bootstrap-config --install --set spec.aws.iamServiceAccounts.iamRoleArn=arn:aws:iam::$AWS_ACCOUNT_ID:role/$IAM_ROLE_NAME


SA=$(kubectl -n crossplane-system get sa -o name | grep provider-kubernetes | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding provider-kubernetes-admin-binding --clusterrole cluster-admin --serviceaccount="${SA}"

SA=$(kubectl -n crossplane-system get sa -o name | grep provider-helm | sed -e 's|serviceaccount\/|crossplane-system:|g')
kubectl create clusterrolebinding provider-helm-admin-binding --clusterrole cluster-admin --serviceaccount="${SA}"

echo "Avßailable metis CRDS..."
kubectl get crds | grep metis