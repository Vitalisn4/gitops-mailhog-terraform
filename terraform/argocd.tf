# Resource 1: A Kubernetes Namespace for Argo CD to live in.
# This keeps our cluster organized.
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

# Resource 2: The Argo CD application itself, installed via Helm.
# Helm is a package manager for Kubernetes.
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata.0.name # Install into the namespace we just defined
  version    = "5.51.2" # Lock to a specific version for predictable results

  # This is important! It tells Terraform:
  # "Do not try to install the Helm chart until the namespace has been successfully created."
  depends_on = [
    kubernetes_namespace.argocd
  ]
}
