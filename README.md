# scw-tor-relay
Infrastructure as code for install a tor relay on Scaleway.

## Prerequisites
Download [Terraform](https://www.terraform.io), [python 3](https://www.python.org) and [Ansible](https://www.ansible.com). Installation of server is done by terraform, and provisionning by Ansible.
You need create an account at [Scaleway](https://www.scaleway.com/), a french cloud provider. On Scaleway dashboard, add your SSH plublic key and create an API token.

## Files
* main.tf : Terraform script for create server at Scaleway.
* output.tf : Terraform script for print server name and ip after the 
* main.yml : Ansible playbook for install Tor relay on the server.

## Installation

Replace following lines by your API token:
* "SCALEWAY_ACCESS_KEY"
* "SCALEWAY_SECRET_KEY"
* "SCALEWAY_ORGANIZATION_ID"

Install terraform plugin:
```shell
terraform init
```

Install server with terraform:
```shell
terraform apply
```

Modify /etc/ansible/hosts and add IP adresse of your server, obtained by the output of terraform:
```shell
vim /etc/ansible/hosts
```

Install and configure Tor relay on the server
```shell
ansible-playbook main.yml
```

If you want, you can delete Tor relay by:
```shell
terraform destroy
```
