# GCP Terraform Setup for VPC, GKE, and Kubectl Access

This repository contains Terraform code for setting up a cloud infrastructure on Google Cloud Platform (GCP). The setup includes a **bastion instance**, a **GKE cluster** in a private subnet, and a **kubectl instance** for managing the cluster.

---

## 📁 Project Structure

```
management/
  ├── 00-hyper-management-compute.tf    # Compute API configurations
  ├── 01-hyper-management-vpc.tf        # Management VPC and subnets
  ├── 02-hyper-management-firewall.tf   # Firewall rules for management VPC
  ├── 03-hyper-management-bastion.tf    # Management bastion instance
  ├── 04-hyper-management-kubectl.tf    # Kubectl instance for cluster access
  ├── 05-hyper-management-peering.tf    # Peering connection for management VPC
  ├── provider.tf                       # Terraform provider configuration
  ├── state.tf                          # Terraform backend configuration
development/
  ├── 01-hyper-development-vpc.tf       # Development VPC and subnets
  ├── 02-hyper-development-peering.tf   # Peering connection for development VPC
  ├── 03-hyper-development-gke.tf       # GKE cluster and node pools
  ├── 04-hyper-development-firewall.tf  # Firewall rules for development VPC
  ├── provider.tf                       # Terraform provider configuration
  ├── state.tf                          # Terraform backend configuration
modules/
  ├── management-vpc/
  ├── management-compute/
  ├── management-kubectl/
  ├── management-bastion/
  ├── development-vpc/
  ├── development-gke/

README.md                               # Documentation
```

---

## 🚀 Features

- **Management VPC**: Contains public and private subnets, NAT gateways, and flow logs.
- **Development VPC**: Houses the GKE cluster within private subnets for secure operation.
- **Kubectl Instance**: Used for managing the GKE cluster, with SSH and `kubectl` pre-installed.

---

## ⚙️ Prerequisites

1. **Tools Required:**
   
   - [Terraform](https://www.terraform.io/downloads.html)
   - [gcloud CLI](https://cloud.google.com/sdk/docs/install)
   - SSH client for remote access to instances

2. **Environment Variables:**
   
   Set the following variables in your environment:
   
   ```bash
   export GOOGLE_PROJECT_ID=<your-project-id>
   export GOOGLE_CREDENTIALS=<path-to-service-account-key.json>
   export GOOGLE_REGION=<your-region>

---

## 🛠️ Setup and Deployment

**1. Clone the Repository**

```yaml
  git clone <repository-url>
  cd <repository-folder>
```

**2. Initialize Terraform**

```yaml
terraform init
```
**3. Plan the Deployment**

```yaml
terraform plan
```
**4. Apply the Configuration**

```yaml
terraform apply
```
---

## 🔑 Configuring kubectl Access

**1. SSH into the kubectl Instance**

```yaml
ssh -i ~/.ssh/<PRIVATE_KEY> kubectl@<INSTANCE_EXTERNAL_IP>
```

**2. Set Up kubeconfig**

Run the following commands to set up access to the GKE cluster:

```yaml
gcloud auth login
gcloud container clusters get-credentials <CLUSTER_NAME> --region <CLUSTER_REGION>
```

**3. Verify Access**

```yaml
kubectl get pods --all-namespaces
```
