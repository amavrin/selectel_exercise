# Selectel Exercise

## General description

This repo contains Terraform scripts and Ansible playbooks/roles
for the setup of the required infrastructure.

Servers generated are
* worker `server-X` servers, where `X` is 0, 1, 2... up to the
  `server_count` total: `server-0`, `server-1`, ...
* `management-server` with Prometheus installed.

Steps to set up the system:

1. Create project in Control Panel, set up user
1. Set the necessary variables (see below)
1. Run Terraform to bring servers up. This also creates
   Ansible inventory files.
1. Run Ansible playbook to set up servers.

See below for detailed description.

## Preparation steps

1. Create a project in Selectel CP
1. Create user `tform` (or adjust `user_name` in `provider.tf`)
1. Make sure project quota allows for the required amount of floating IPs.

## Configure Terraform

1. Set `domain_name` to the account number in `provider.tf`.
1. Set `tenant_id` in `provider.tf` to the project ID.
1. Set `TF_VAR_selectel_tform_passwd` environment variable to `tform` user's
   password
1. Set `region`, `az_zone`, `volume_type`, `subnet_cidr` in `vars.tf`.
1. Set desired manages server count as `server_count` in `vars.tf`.
1. Generate key pair. Copy the public key value into the variable `public_key`
   in `keys.tf`. Set filename of private key in `vars.tf` as `private_key_file`.

## Run `terraform init`, `plan` and `apply`

Execute
```
terraform init
terraform plan
terraform apply
```
**Note** you may need a VPN to install Terraform providers.

Terraform writes 2 files upon successful execution:

1. `files/ssh_config` file, which can be used to connect
   to the project servers like
   ```
   ssh -F files/ssh_config server-0
   ```
1.  Ansible inventory in the `./ansible/inventory/hosts` file.

## Run Ansible playbook

1. Check that Prometheus and Node Exporter version
   set in `ansible/playbooks/setup.yml` suits your requirements.

1. To execute Ansible, change directory to `./ansible/` and run
   the `setup.yml` playbook:
   ```
   cd ansible/
   ansible-playbook playbooks/setup.yml
   ```

You may need to wait a bit for ssh to be available on servers.

## Prometheus Web UI

Find out the IP address of the management serger (one way to do
it is to look inside the `files/ssh_config` file) and go to
http://MANAGEMENT-SERVER-IP:9090/

## Caveats

https://releases.hashicorp.com/terraform/ is blocking access (from Russia?).
