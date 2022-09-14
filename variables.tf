# Input variable definitions

variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "hcloud_server_type" {
  description = "vServer type name, lookup via `hcloud server-type list` Requires at least 3GB of RAM"
  type        = string
  default     = "cx21"
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

variable "tools_butane_version" {
  description = "See https://quay.io/repository/coreos/butane?tag=latest&tab=tags for available versions"
  type        = string
  default     = "release"
}

variable "ignition_yaml" {
  description = "Ignition configuration that will be passed to butane"
  type        = string
  default     = "config.yaml"
}
