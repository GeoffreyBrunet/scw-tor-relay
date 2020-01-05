provider "scaleway" {
  access_key      = "SCALEWAY_ACCESS_KEY"
  secret_key      = "SCALEWAY_SECRET_KEY"
  organization_id = "SCALEWAY_ORGANIZATION_ID"
  zone            = "fr-par-1"
  region          = "fr-par"
}

data "scaleway_account_ssh_key" "my_key" {
  ssh_key_id = "11111111-1111-1111-1111-111111111111"
}

resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_security_group" "www" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
  }

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }
}

resource "scaleway_instance_server" "tor" {
  type  = "DEV1-S"
  image = "ubuntu-bionic"
  tags = [ "tor" ]
  ip_id = scaleway_instance_ip.public_ip.id
  security_group_id = scaleway_instance_security_group.www.id
}
