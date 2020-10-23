variable "prefix" {
  description   = "The prefix which should be used for all resources"
  default       = "osh3"
}

variable "location" {
  description   = "The Azure Region in which all resources have to be created"
  default       = "North Europe"
}

variable "tags" {
  type          = map

  default = {
    Project     = "Leche Dos Pinos"
    Dept        = "Engineering"
  }
}

variable "DB_firewall_IP1" {
  type = string
  default     = "201.204.81.164"
  description = "Permitted IP address for access DB"
}
variable "DB_firewall_IP2" {
  type = string
  default     = "201.197.189.58"
  description = "Permitted IP address for access DB"
}
variable "DB_firewall_IP3" {
  type = string
  default     = "186.179.66.78"
  description = "Permitted IP address for access DB"
}
variable "DB_firewall_IP4" {
  type = string
  default     = "186.15.229.200"
  description = "Permitted IP address for access DB"
}
variable "DB_firewall_IP5" {
  type = string
  default     = "190.171.112.69"
  description = "Permitted IP address for access DB"
}
variable "DB_firewall_IP6" {
  type = string
  default     = "52.143.241.225"
  description = "Permitted IP address for access DB"
}
variable "DB_firewall_IP7" {
  type = string
  default     = "104.43.163.210"
  description = "Permitted IP address for access DB"
}


variable "virtual_network_address_space"{
  type = string
  default     = "10.0.0.0/16"
  description = ""
} 

variable "subnet_address_space"{
  type = string
  default     = "10.0.1.0/24"
  description = ""
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
