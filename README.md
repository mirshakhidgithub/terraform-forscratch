# Terraform + Ansible: DigitalOcean Nginx

This repository contains a small Terraform/Ansible assignment:

- Terraform creates exactly one DigitalOcean Droplet.
- Terraform registers the supplied local SSH public key in DigitalOcean.
- Terraform creates a Cloud Firewall allowing SSH (`22/tcp`) and HTTP (`80/tcp`).
- Terraform renders `inventory.yml` from `inventory.yml.tftpl` using the created Droplet IPv4 address.
- Ansible installs and starts Nginx without using roles.

## Requirements

- Terraform >= 1.5
- Ansible
- DigitalOcean API token
- SSH key pair (default: `~/.ssh/id_ed25519` and `~/.ssh/id_ed25519.pub`)

## Usage

Export the DigitalOcean token instead of storing it in the repository:

```bash
export DIGITALOCEAN_TOKEN='your-token'
```

Initialize and inspect the Terraform plan:

```bash
terraform init
terraform plan
```

Create the single test VPS and generate the YAML inventory:

```bash
terraform apply
```

Run Ansible:

```bash
ansible-playbook ansible/playbook.yml
```

Check Nginx:

```bash
curl http://$(terraform output -raw droplet_ipv4)
```

After the assignment has been checked, remove the VPS and all Terraform-created resources:

```bash
terraform destroy
```

Do not commit `terraform.tfstate`, `.terraform/`, API tokens, or private SSH keys.