
variable "vnet-name" {
  type        = string
  default     = "vnet-terraform-01"
  description = "The name of Vnet"
}

variable "location" {
  type        = string
  default     = "koreacentral"
  description = "Location of the resource group."
}

variable "rg-name" {
  type        = string
  default     = "rg"
  description = "The name of resource group"
}

