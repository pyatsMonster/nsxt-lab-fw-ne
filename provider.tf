terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
      version = ">= 3.1.1"
    }
  }
  backend "remote" {
    hostname = "onprem-tfe-prod.wwmgmt.intraxa"
    organization = "network"

    workspaces {
      name = "nsxt-lab-fw-ne-dev"
    }
  }
}

provider "nsxt" {
  host                  = "NSX-T-Manager-VIP.nedc.mgmt.axa-tech.intraxa"
  username              = "admin"
  password              = var.password
  remote_auth		= false
  allow_unverified_ssl  = true
  max_retries           = 3
  retry_min_delay       = 120
  retry_max_delay       = 1200
  retry_on_status_codes = [429]
}
