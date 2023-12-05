terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.47.0"
    }
  }
}

provider "openstack" {
  application_credential_id = var.auth_data.credential_id
  application_credential_secret = var.auth_data.credential_secret
  auth_url    = var.auth_data.auth_url
}

resource "openstack_compute_instance_v2" "kubernetes_master" {
  name            = var.kubernetes_master_node.name
  flavor_name     = var.kubernetes_master_node.flavor_name
  key_pair        = var.kubernetes_master_node.key_pair
  security_groups = ["${openstack_networking_secgroup_v2.terraform_kubernetes_master.name}", "${openstack_networking_secgroup_v2.terraform_kubernetes_all.name}", "ssh", "default"]

  network {
    name = var.kubernetes_network.name
  }

  block_device {
    uuid                  = var.kubernetes_master_node.image_id
    source_type           = "image"
    volume_size           = var.kubernetes_master_node.volume_size
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = var.kubernetes_master_node.floating_ip
  instance_id = openstack_compute_instance_v2.kubernetes_master.id
}


resource "openstack_compute_instance_v2" "kubernetes_worker" {
  name            = "${var.kubernetes_worker_node.name}-${count.index+1}"
  count           = var.kubernetes_worker_node.count
  flavor_name     = var.kubernetes_worker_node.flavor_name
  key_pair        = var.kubernetes_worker_node.key_pair
  security_groups = ["${openstack_networking_secgroup_v2.terraform_kubernetes_all.name}", "ssh", "default"]

  network {
    name = var.kubernetes_network.name
  }

  block_device {
    uuid                  = var.kubernetes_worker_node.image_id
    source_type           = "image"
    volume_size           = var.kubernetes_worker_node.volume_size
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
}

resource "openstack_compute_instance_v2" "nfs_server" {
  name            = var.nfs_server.name
  flavor_name     = var.nfs_server.flavor_name
  key_pair        = var.nfs_server.key_pair
  security_groups = ["${openstack_networking_secgroup_v2.terraform_kubernetes_all.name}" , "ssh", "default"]

  network {
    name = var.kubernetes_network.name
  }

  block_device {
    uuid                  = var.nfs_server.image_id
    source_type           = "image"
    volume_size           = var.nfs_server.volume_size
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tpl",
    {
      k8s_master = tolist([openstack_compute_instance_v2.kubernetes_master.network.0.fixed_ip_v4])
      k8s_worker = tolist([openstack_compute_instance_v2.kubernetes_worker[0].network.0.fixed_ip_v4, openstack_compute_instance_v2.kubernetes_worker[1].network.0.fixed_ip_v4]) 
      nfs =  tolist([openstack_compute_instance_v2.nfs_server.network.0.fixed_ip_v4])
    }
  )
  filename = "../ansible/hosts"
}




