#Terraform documentation : https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

variable "chart" {
  description = "Chart name to be installed"
  type = string
}

variable "name" {
  description = "name of the release"
  type = string
}

variable "create_namespace" {
  description = "Create the namespace if it does not exist"
  type = bool
}

variable "repository" {
  description = "Repository where to locate the requested chart"
  type = string
}

variable "chart_version" {
  description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
  type = string
}

variable "namespace" {
  description = "Namespace to install the release into"
  type = string
}

variable "set_values" {
  description = "Map of key-value pairs to set in the Helm chart"
  type        = map(string)
  default     = {}
}

