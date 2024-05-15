output "platform" {
  value = { 
    name = yandex_compute_instance.platform.name
    external_ip = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    fqdn = yandex_compute_instance.platform.fqdn
  }
}

output "netology-develop" {
  value = { 
    name = yandex_compute_instance.netology-develop.name
    external_ip = yandex_compute_instance.netology-develop.network_interface.0.nat_ip_address
    fqdn = yandex_compute_instance.netology-develop.fqdn
  }
}