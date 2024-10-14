variable "environment"    { default = "dev" }
variable "main_project"   { default = "ma" }
variable "sub_project"    { default = "su" }
variable "location"       { default = "uksouth"}
variable "tags" {
      default = {
        environment = "dev"
        project     = "example-project"
      }
}