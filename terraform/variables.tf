variable "auth_data" {
  type = object({
    credential_id = string
    credential_secret = string
    auth_url = string
  })
  sensitive = true
}

variable "kubernetes_master_node" {
  type = object({
    name = string
    flavor_name = string
    image_id = string
    key_pair = string
    floating_ip = string
    volume_size = number
})
}

variable "kubernetes_worker_node" {
  type = object({
    name = string
    count = number
    flavor_name = string
    image_id = string
    key_pair = string
    volume_size = number
})
}

variable "nfs_server" {
  type = object({
    name = string
    flavor_name = string
    image_id = string
    key_pair = string
    volume_size = number
})
}

variable "kubernetes_network" {
  type = object({
    name = string
    network_subnet_range = string
})
}


