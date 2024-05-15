###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = "b1gcrqu772dos233asd0"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gmhlplt9a399ueaniq"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "network1"
  description = "VPC network & subnet name"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image family"
}

/*variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "yandex_compute_instance name"
}*/

###ssh vars

variable "vms_ssh_root_key" {
  type        = map(string)
  default     = {
    serial_port_enable = "1"
    ssh_key = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVEYZ5+FWuDUrMYn5bgcBFR1oF1zSWNPJ5XWqAZpq/G artem@Dell-Nout"
    }
  description = "ssh-keygen -t ed25519"
}

variable "vm_db_web_resources" { 
  type         = map(map(number))
  default      = {
    web_res = {
      cores = 2
      memory = 2
      core_fraction = 20
    }
    db_res = {
      cores = 2
      memory=1
      core_fraction=20
    }
  }
}