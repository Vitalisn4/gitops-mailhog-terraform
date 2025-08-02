terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20" # Use any version in the 2.20.x range
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10" # Use any version in the 2.10.x range
    }
  }
}

# Configure the Kubernetes provider
provider "kubernetes" {
  # This block tells Terraform to find and use the same configuration
  # file that kubectl uses. Minikube set this up for us automatically.
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

# Configure the Helm provider
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}
