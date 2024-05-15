###cloud vars
/*variable "vm_db_token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}*/

variable "vm_db_cloud_id" {
  type        = string
  default     = "b1gcrqu772dos233asd0"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "vm_db_folder_id" {
  type        = string
  default     = "b1gmhlplt9a399ueaniq"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_name" {
  type        = string
  default     = "network2"
  description = "VPC network & subnet name"
}

variable "vm_db_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image family2"
}

/*variable "vm_db_web_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "yandex_compute_instance name2"
}*/

###ssh vars

/*variable "vm_db_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVEYZ5+FWuDUrMYn5bgcBFR1oF1zSWNPJ5XWqAZpq/G artem@Dell-Nout"
  description = "ssh-keygen -t ed25519"
}*/
