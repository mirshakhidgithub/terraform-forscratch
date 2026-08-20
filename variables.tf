variable "region" {
  description = "DigitalOcean region for the Droplet"
  type        = string
  default     = "fra1"
}

variable "droplet_name" {
  description = "Droplet name"
  type        = string
  default     = "terraform-ansible-nginx"
}

variable "droplet_size" {
  description = "DigitalOcean Droplet size slug"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key registered in DigitalOcean"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_private_key_path" {
  description = "Path written to Ansible inventory for SSH connections"
  type        = string
  default     = "~/.ssh/id_ed25519"
}

variable "ssh_user" {
  description = "SSH user for the Ubuntu Droplet"
  type        = string
  default     = "root"
}
