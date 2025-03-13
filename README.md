# Terraform Deployment on Google Cloud

This guide will walk you through setting up and executing Terraform to deploy infrastructure on Google Cloud Platform (GCP).

## Prerequisites
Ensure you have the following installed and configured before proceeding:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)
- A Google Cloud project with billing enabled
- IAM permissions: `Owner` or `Editor` role
- A service account with `roles/editor` and `roles/iam.serviceAccountUser`
- Enable necessary APIs:
  ```sh
  gcloud services enable compute.googleapis.com container.googleapis.com
  ```

## Setup and Execution

### 1. Authenticate with Google Cloud
If you haven't authenticated yet, run:
```sh
gcloud auth application-default login
```
This allows Terraform to authenticate with your Google Cloud account.

### 2. Set Google Cloud Project
Set your active project:
```sh
gcloud config set project <PROJECT_ID>
```
Replace `<PROJECT_ID>` with your actual project ID.

### 3. Initialize Terraform
Navigate to your Terraform project directory and run:
```sh
terraform init
```
This initializes Terraform and downloads necessary providers.

### 4. Plan Deployment
Preview the resources Terraform will create:
```sh
terraform plan
```
This step helps you verify the changes before applying them.

### 5. Apply Terraform Configuration
Deploy resources to Google Cloud:
```sh
terraform apply
```
Type `yes` when prompted to confirm the deployment.

### 6. Verify Deployment
After Terraform completes, verify the resources in Google Cloud:
```sh
gcloud compute instances list
gcloud container clusters list
```

## Troubleshooting
- If you encounter authentication errors, re-run:
  ```sh
  gcloud auth application-default login
  ```
- Ensure that your service account has the necessary permissions.
- Check for API enablement using:
  ```sh
  gcloud services list
  ```

---

# Kubernetes Setup

## 1. Setup Emissary

### Add the Repository:
```sh
helm repo add datawire https://app.getambassador.io
helm repo update
```

### Create Namespace and Install:
```sh
kubectl create namespace emissary && \
kubectl apply -f https://app.getambassador.io/yaml/emissary/3.9.1/emissary-crds.yaml
```

### Wait for Deployment:
```sh
kubectl wait --timeout=90s --for=condition=available deployment emissary-apiext -n emissary-system
```

### Install Emissary:
```sh
helm install emissary-ingress --namespace emissary datawire/emissary-ingress && \
kubectl -n emissary wait --for condition=available --timeout=90s deploy -lapp.kubernetes.io/instance=emissary-ingress
```

## 2. Setup Airbyte

### Add a Remote Helm Repo:
```sh
helm repo add airbyte https://airbytehq.github.io/helm-charts
helm repo update
kubectl create namespace airbyte
```

### Create Configuration File (`values.yaml`):
```yaml
global:
  airbyteUrl: https://airbyte.cloudtest1.my.id/
```

### Install Airbyte:
```sh
helm install \
airbyte \
airbyte/airbyte \
--namespace airbyte \
--values ./values.yaml
```

### Verify Installation:
```sh
kubectl get all -n airbyte
```

## 3. Setup Let's Encrypt

### Add the Jetstack Helm Repo:
```sh
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

### Install Cert-Manager:
```sh
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --set installCRDs=true
```

## 4. Deploy Kubernetes Configuration
Apply Kubernetes configuration files located in the `k8s` directory:
```sh
kubectl apply -f ./k8s
```

