# Input variable definitions

variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "hcloud_server_type" {
  description = "vServer type name, lookup via `hcloud server-type list` Requires at least 3GB of RAM"
  type        = string
  default     = "cx11"
}

variable "hcloud_server_datacenter" {
  description = "Desired datacenter location name, lookup via `hcloud datacenter list`"
  type        = string
  default     = "fsn1-dc14"
}

variable "hcloud_server_name" {
  description = "Name of the server"
  type        = string
  default     = "www1"
}

variable "ssh_public_key_name" {
  description = "Name of your public key to identify at Hetzner Cloud portal"
  type        = list(string)
  default     = ["My-SSH-Key"]
}

variable "ssh_private_key_path" {
  description = "Name of your public key to identify at Hetzner Cloud portal"
  type        = string
  default     = "private_key"
}

variable "ignition_ign" {
  description = "Ignition configuration that will be passed to butane"
  type        = string
  default     = "config.ign"
}

variable "coreos_version" {
  description = "core_os_version"
  type        = string
  default     = "36.20220820.3.0"
}