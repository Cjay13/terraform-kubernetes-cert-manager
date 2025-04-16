variable "namespace" {
    type = string
    description = "Namespace to install cert-manager"
    default = "cert-manager"
}

variable "chart_version" {
    type = string
    description = "Version of the cert-manager helm chart"
    default = "v1.17.0"
}

variable "create_clusterIssuer" {
    type = bool
    description = "Whether to create a clusterIssuer or not"
    default = false
}

variable "clusterIssuer_name" {
    type = string
    description = "Name of the clusterIssuer"

    validation {
        condition     = !var.create_clusterIssuer || (length(var.clusterIssuer_name) > 0)
        error_message = "clusterIssuer_name must be provided when create_clusterIssuer is true."
    }
}

variable "letsencrypt_email" {
  type        = string
  description = "Email used for ACME registration"

  validation {
    condition     = !var.create_clusterIssuer || (length(var.letsencrypt_email) > 0)
    error_message = "letsencrypt_email is required when create_clusterIssuer is true."
  }
}

variable "acme_server_url" {
  type        = string
  default     = "https://acme-v02.api.letsencrypt.org/directory"
  description = "ACME server endpoint"
}

variable "private_key_secret_name" {
  type        = string
  description = "Secret to store ACME account private key"
  validation {
    condition     = !var.create_clusterIssuer || (length(var.private_key_secret_name) > 0)
    error_message = "private_key_secret_name is required when create_clusterIssuer is true."
  }
}

variable "ingress_class" {
  type        = string
  description = "Ingress class name for HTTP-01 challenge"
  validation {
    condition     = !var.create_clusterIssuer || (length(var.ingress_class) > 0)
    error_message = "ingress_class is required when create_clusterIssuer is true."
  }
}