variable "api_version" {
  description = "API version of the cluster issuer"
  type = string
  default = "cert-manager.io/v1"
}

variable "name" {
  description = "Name of the cluster issuer"
  type = string
}

variable "email" {
  description = "Email address to receive warnings about certificate expirations"
  type = string
}

variable "server" {
  description = "Host name of the certificate lifecycle management server"
  type = string
  default = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "ingress_class_name" {
  description = "Name of the ingress class"
  type = string

  validation {
    condition = contains(["nginx"],var.ingress_class_name) #add other types of ingress class names here
    error_message = "Please select a valid ingress class name. Example :- nginx"
  }
}