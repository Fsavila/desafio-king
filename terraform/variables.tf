variable "project" {
  default = "idProjeto"  # Alterar para o ID do seu Projeto no GCP
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

variable "ssh_user" {
  default = "usuario" # Alterar para o seu Usuário
}

variable "ssh_key" {
  default = "caminhoCompleto/id_rsa.pub" # Alterar com o caminho da sua chave pública ssh 
} 

variable "ports" {
    type    = list
    default = [80, 443, 5000]
  
}