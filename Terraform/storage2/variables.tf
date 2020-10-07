variable "prefix" {
  description   = "The prefix which should be used for all resources in this example"
  default       = "osh2"
}

variable "location" {
  description   = "The Azure Region in which all resources in this example should be created."
  default       = "West Europe"
}

variable "tags" {
  type          = map

  default = {
    Project     = "Leche Dos Pinos"
    Dept        = "Engineering"
  }
}

variable "client_id" {
  default     = "2897992b-3864-4e78-ab49-10db8c9dc37e"
}

variable "subscription_id" {
  default     = "f5b5d7b3-27e6-47ba-83c1-58824d3eb42b"
}

variable "tenant_id" {
  default     = "7d47fcaf-becc-4b18-9e09-eca423481012"
}

variable "client_secret" {}