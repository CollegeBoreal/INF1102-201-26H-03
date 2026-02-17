terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.0"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_url
  pm_api_token_id     = var.pm_token_id
  pm_api_token_secret = var.pm_token_secret
  pm_tls_insecure     = true
}
