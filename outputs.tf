output "droplet_ipv4" {
  description = "Public IPv4 address of the created Droplet"
  value       = digitalocean_droplet.web.ipv4_address
}

output "ansible_inventory" {
  description = "Generated Ansible inventory path"
  value       = local_file.ansible_inventory.filename
}
