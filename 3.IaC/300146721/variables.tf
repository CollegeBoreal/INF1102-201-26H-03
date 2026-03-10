variable "pm_vm_name" { type = string }

variable "pm_target_node" {
  type    = string
  default = "labinfo"
}

variable "pm_clone_template" {
  type    = string
  default = "ubuntu-jammy-template"
}

variable "pm_ipconfig0" { type = string }
variable "pm_nameserver" { type = string }

variable "pm_url" { type = string }
variable "pm_token_id" { type = string }

variable "pm_token_secret" {
  type      = string
  sensitive = true
}
