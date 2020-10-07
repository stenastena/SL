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
