provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_server" "instance" {
  name   = var.hcloud_server_name
  labels = { "os" = "coreos" }

  server_type = var.hcloud_server_type
  datacenter  = var.hcloud_server_datacenter

  # Image is ignored, as we boot into rescue mode, but is a required field
  image    = "fedora-36"
  rescue   = "linux64"
  ssh_keys = var.ssh_public_key_name

  connection {
    host    = hcloud_server.instance.ipv4_address
    private_key = file(var.ssh_private_key_path)
    timeout = "5m"
    agent   = false

    # Root is the available user in rescue mode
    user = "root"
  }

  # Copy config.yaml
  provisioner "file" {
    source      = var.ignition_ign
    destination = "/root/config.ign"
  }

  # Install Fedora CoreOS in rescue mode
  provisioner "remote-exec" {
    inline = [
      "set -x",
      "export COREOS_DISK=https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${var.coreos_version}/x86_64/fedora-coreos-${var.coreos_version}-metal.x86_64.raw.xz",
      "curl -sL $COREOS_DISK | xz -d | dd of=/dev/sda status=progress",
      "mount /dev/sda3 /mnt",
      "mkdir /mnt/ignition",
      "mv /root/config.ign /mnt/ignition/config.ign",
      "unmount /mnt",
      "reboot",
    ]
  }

  # Configure CoreOS after installation
  provisioner "remote-exec" {
    connection {
      host    = hcloud_server.instance.ipv4_address
      private_key = file(var.ssh_private_key_path)
      timeout = "2m"
      agent   = false
      # This user is configured in config.yaml
      user = "core"
    }

    inline = [
      "sudo hostnamectl set-hostname ${hcloud_server.instance.name}"
      # Add additional commands if needed
    ]
  }
}
