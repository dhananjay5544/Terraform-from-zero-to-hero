variable "subscription_id" {
  type = string
  description = "azure subscription id."
}

variable "resourceGroupName" {
  type = string
  description = "resource group name."
}

variable "location" {
  type = string
  description = "location name."
}

variable "prefix" {
  default = "mastery"
}
