# Nome do ID projeto criado no painel do GCP
variable "idProjeto" {
  default = "projeto-infra-326302"
}

# Região e zona da instancia que vai ser criada, existe uma lista no GCP para consulta.
variable "regiao" {
  default = "southamerica-east1"
}

variable "zona" {
  default = "southamerica-east1-b"
}

# Nome para sua Instancia de VM's
# Sim eu imitei a nomeclatura da king kkkkk
variable "nomeVM" {
  default = "web10"
}

# Quantidade  de instancias que deseja lançar
variable "quant" {
  default = 1
}

# Configuração da instancia (Aqui é definido quantidade de memória nucleos de cpu etc...)
variable "tipoInstancia" {
  default = "n2-standard-2"
}

# SO que pretende usar em suas instancias.
variable "imagem" {
  default = "centos-7"
}

# Portas que vão ser liberadas na FIRST. (Primeira camada de firewall dos servidores)
# OBS não confuda com firewall de dentro da instancia, isto é como se fosse na borda do roteador.

variable "portas" {
  default = ["80", "8888", "8080", "443"]
}

# Nome para sua Camada de FireWall (First)
variable "FWNameServer" {
  default = "firewall-instancias"
}
