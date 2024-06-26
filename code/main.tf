resource "yandex_vpc_network" "develop1" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop1.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}
resource "yandex_compute_instance" "platform" {
  # name        = var.vm_web_name
  name        = local.vm_web_lname
  platform_id = "standard-v3"

  resources {
    core_fraction = var.vm_db_web_resources.web_res.core_fraction
    cores         = var.vm_db_web_resources.web_res.cores
    memory        = var.vm_db_web_resources.web_res.memory
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.vms_ssh_root_key

}

resource "yandex_vpc_network" "develop2" {
  name = var.vm_db_name
}
resource "yandex_vpc_subnet" "develop3" {
  name           = var.vm_db_name
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.develop2.id
  v4_cidr_blocks = var.vm_db_default_cidr
}


data "yandex_compute_image" "ubuntu2" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "netology-develop" {
  # name        = var.vm_db_web_name
  name        = local.vm_db_lname
  platform_id = "standard-v3"
  zone        = var.vm_db_default_zone

  resources {
    core_fraction = var.vm_db_web_resources.db_res.core_fraction
    cores         = var.vm_db_web_resources.db_res.cores
    memory        = var.vm_db_web_resources.db_res.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu2.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop3.id
    nat       = true
  }

  /*metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vm_db_ssh_root_key}"
  }*/

  metadata = var.vms_ssh_root_key

}