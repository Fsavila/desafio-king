variable "project" {
  default = "desafioking"
}

variable "region" {
  default = "southamerica-east1"
}

variable "credentials" {
  default = "credentials.json"
}

variable "name_vm" {
    default = "web"  
}

variable "machine_type" {
    default = "n1-standard-2"    
}

variable "image_os" {
    default = "centos-7"  
}

variable "ssh_key" {
  default = "/home/bruno/.ssh/id_rsa.pub"
} 

variable "ports" {
    type    = list
    default = [80, 443, 5000]
  
}