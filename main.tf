provider "digitalocean" {}

resource "digitalocean_ssh_key" "ansible" {
  name       = "terraform-ansible-key"
  public_key = file(pathexpand(var.ssh_public_key_path))
}

resource "digitalocean_droplet" "web" {
  name     = var.droplet_name
  region   = var.region
  size     = var.droplet_size
  image    = "ubuntu-24-04-x64"
  ssh_keys = [digitalocean_ssh_key.ansible.fingerprint]

  tags = ["terraform-ansible-nginx"]
}

resource "digitalocean_firewall" "web" {
  name        = "${var.droplet_name}-firewall"
  droplet_ids = [digitalocean_droplet.web.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible/inventory.yml"

  content = templatefile("${path.module}/inventory.yml.tftpl", {
    droplet_ip          = digitalocean_droplet.web.ipv4_address
    ssh_user            = var.ssh_user
    ssh_private_key     = pathexpand(var.ssh_private_key_path)
  })

  file_permission = "0644"
}
