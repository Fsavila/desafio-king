#Concede o acesso a todas as funcionalidades do projeto criado.

provider "google" {
  credentials = "${file("codigo-acesso-gcp.json")}"
  project     = "${var.idProjeto}"
  region      = "${var.regiao}"
}


# Cria a VM com o Google Compute Engine
resource "google_compute_instance" "webserver" {
  count = "${var.quant}"
  name          = "${var.nomeVM}${count.index}"
  machine_type  = "${var.tipoInstancia}"
  zone          = "${var.zona}"

  boot_disk {
    initialize_params {
      image = "${var.imagem}"
    }
  }

  # Pode ser usado para configurar algum firewall ou qualquer outro comando bash que necessite antes do ansible 
  # (não recomendado afinal o ansible pode fazer isso para nós.) 

  metadata_startup_script = ""

  # Habilita rede para a VM bem como um IP público
  network_interface {
    network = "default"
    access_config {

    }
  }

#Lembre de criar sua chave publica SSH para acessar o servidor. 
#Aonde diz meu usuario "anderson" deve ser trocado para o usuario da chave importada,
#Geralmente usamos o root mas nesse caso faremos no nosso usuario atual.
  
  metadata = {
   ssh-keys = "anderson:${file("~/.ssh/id_rsa.pub")}" 
  }

#Aqui facilitamos o uso para adicionar o hosts no arquivo de acesso do ansible.
#Quando ele da o self ele entra na categoria do networ_kinterface e retorna a config nat_ip que seria o IP de acesso da instancia.

    provisioner "local-exec" {
      command = "echo \"\n${self.network_interface.0.access_config.0.nat_ip}\" >> ./hosts"
  }
}

# Cria o Firewall para a VM
resource "google_compute_firewall" "webfirewall" {
  name        = "${var.FWNameServer}"
  network     = "default"

  allow {
    protocol  = "tcp"
    ports     = "${var.portas}"
  }
}

