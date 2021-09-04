terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.57.0"
    }
    local = {
      source = "hashicorp/local"
      version = ">= 2.1.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.4.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.3.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = ">= 3.1.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}
