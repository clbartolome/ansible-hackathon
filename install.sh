#!/bin/bash

# Get the OpenShift API server URL
api_server=$(oc whoami --show-server)

# Extract the base domain from the API server URL
base_domain=$(echo $api_server | awk -F[/:] '{print $4}' | sed 's/^api\.//')

# Gitea
oc new-project gitea

# App Namespaces
for i in {1..10};
do
oc new-project group-$i
cat <<EOF | oc apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: frontend-cm
  namespace: group-$i
  labels:
    app: exchange
data:
  REACT_CONFIG: |
    {
      "REACT_APP_BACKEND": "http://backend-group-$i.apps.${base_domain}"
    }
EOF
done

# Define parameters for creating users in htpasswd

PASSWORD="ansible"
OUTPUT_FILE=".htpasswd"

# Create htpasswd file

touch .htpasswd

# Add content to htpasswd

for i in {1..10}
do
    USER="group-$i"
    htpasswd -b $OUTPUT_FILE $USER $PASSWORD
done

# Create Secret and add htpasswd content

oc create secret generic htpass-secret --from-file=htpasswd=".htpasswd" -n openshift-config

# Create Oauth provider and link to secret

cat <<EOF | oc apply -f -
apiVersion: config.openshift.io/v1
kind: OAuth
metadata:
  name: cluster
spec:
  identityProviders:
  - name: hackathon
    mappingMethod: claim
    type: HTPasswd
    htpasswd:
      fileData:
        name: htpass-secret
EOF

# GitOps Configuration
oc adm policy add-cluster-role-to-user cluster-admin  system:serviceaccount:openshift-gitops:openshift-gitops-argocd-application-controller -n openshift-gitops

# Create environment using GitOps
oc apply -f deploy/hackathon-environment.yaml

# Instructions
ARGO_USER=admin
ARGO_PASS=$(oc get secret openshift-gitops-cluster -n openshift-gitops -ojsonpath='{.data.admin\.password}' | base64 -d)
ARGO_ROUTE=$(oc get route openshift-gitops-server -n openshift-gitops -o jsonpath='{.status.ingress[0].host}')

echo "Login into ArgoCD using the following info:"
echo ""
echo "    URL: https://$ARGO_ROUTE"
echo "    User: $ARGO_USER"
echo "    Pass: $ARGO_PASS"
echo ""
echo "Review the created resources inside demo-environment app and press SYNC"
