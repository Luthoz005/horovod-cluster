kubernetes_master_node = ({
    name = "d53cj4-master"
    flavor_name = "g2.large"
    image_id = "7c66f474-0e38-47e3-8b1a-d0ad6b774453"
    key_pair = "d53cj4"
    floating_ip = "<floating_ip>"
    volume_size = 50
})

kubernetes_worker_node = ({
    name = "d53cj4-worker"
    count = 2
    flavor_name = "g2.large"
    image_id = "7c66f474-0e38-47e3-8b1a-d0ad6b774453"
    key_pair = "d53cj4"
    volume_size = 50
})

nfs_server = ({
    name = "d53cj4-NFS"
    count = 1
    flavor_name = "g2.large"
    image_id = "7c66f474-0e38-47e3-8b1a-d0ad6b774453"
    key_pair = "d53cj4"
    volume_size = 200
})

kubernetes_network = ({
    name = "default"
    network_subnet_range = "192.168.1.0/24"
})

