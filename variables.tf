variable "project_id" {
    type = string
    description = "project id where u want to create servciea ccount"
  
}
# variable "project_name" {
#     type = string
#     description = "project name "
  
# }
variable "kms_key" {
    type = string
    description = "ksm for encrption and decrption "
  
}
variable "name" {
    type = string 
    description = "desploy name of service account"
  
}
variable "description" {
    type = string
    description = "description of service account"
}