variable "context" {
  description = "The environment context for this operation"
  type = object({
    environment   = string
    business_unit = string
    location      = string
    location_abbr = string
  })
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vm_size" {
  description = "size of the VM"
  type = string
}

variable "private_ip_address_allocation" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  type = string
  default = "Dynamic"
  validation {
    condition = contains(["Dynamic","Static"],var.private_ip_address_allocation)
    error_message = "Selected Private IP address allocation type is wrong, Please select either Dynamic or Static"
  }
}

variable "image_publisher" {
  description = "Publisher of the VM image"
  type = string
}

variable "image_offer" {
  description = "Offer of the VM OS image"
  type = string
}

variable "image_sku" {
  description = "SKU of the VM OS image"
  type = string
}

variable "image_version" {
  description = "version of the OS image"
  type = string
}

variable "computer_name" {
  description = "Specifies the name of the Virtual Machine."
  type = string
}

variable "admin_username" {
  description = "Specifies the name of the local administrator account."
  type = string
}

variable "admin_password" {
  description = "he password associated with the local administrator account."
  type = string
}

variable "subnet_id" {
  description = "The ID of the Subnet where this Network Interface should be located in."
  type = string
}

variable "public_ip_address_id" {
  description = "Reference to a Public IP Address to associate with this NIC"
  type = string
}

variable "usage" {
  description = "Usage of this VM"
  type        = string
}

variable "tags" {
  description = "Tags need to attach to this VM"
  type = map(string)
  default = {}
}
