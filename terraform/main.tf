provider "google" {
    credentials = "${var.credentials}"
    project = "${var.project}"
    region = "${var.region}"
}

resource "google_compute_instance" "webserver" {
    name = "${var.name_vm}-server"
    machine_type = "${var.machine_type}"
    zone = "${var.region}-b"

    boot_disk {
      initialize_params {
        image = "${var.image_os}"
      }
    }

    metadata = {
      "sshkeys" = "bruno:${file(var.ssh_key)}"

    }   

    network_interface {
        network = "default"
        access_config {          
        }
    } 

    provisioner "local-exec" {
        command = "echo \"\n${self.network_interface.0.access_config.0.nat_ip}\" | tee -a ../ansible/hosts"       
    } 
}

resource "google_compute_firewall" "firewall" {
  name = "webserver-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = "${var.ports}"
  }    

    source_ranges = ["0.0.0.0/0"]
}

