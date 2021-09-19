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

