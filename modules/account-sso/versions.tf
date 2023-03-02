terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.56.0"
    }
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "2.0.0"
    }
  }
}
