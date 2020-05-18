variable "subscriptionId" {}
variable "clientId" {}
variable "clientSecret" {}
variable "tenantId" {}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "region" {
  description = "The Azure Region in which all resources in this example should be created"
}

variable "resourceGroup" {
  description = "Resource group"
}

variable "vmSize" {
  description = "Specifies the size of the virtual machine."
}

variable "admin_username" {
  description = "administrator user name"
  default     = "vmadmin"
}

variable "admin_password" {
  description = "administrator password (recommended to disable password auth)"
  default     = "cmpdev@12345"
}

variable "virtual_network_name" {
  description = "The name for the virtual network."
}

variable "subnet_name" {
  description = "The subnet based on the virtual network."
}

variable "image_reference" {
  type = "string"
}

variable "hostname" {
  description = "VM name referenced also in storage-related names."
  default     = "tf"
}
