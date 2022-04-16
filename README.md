# Selectel Exercise

## Prepare

1. Create a project in Selectel CP
1. Create user `tform` (or adjust `user_name` in `provider.tf`)
1. Set `domain_name` to the account number in `provider.tf`.
1. Set `tenant_id` to the project ID.
1. Set `TF_VAR_selectel_tform_passwd` envirinment variable to `tform` user's
   password
1. Set `region`, `az_zone`, `volume_type`, `subnet_cidr`, `selectel_tform_passwd`
   in `vars.tf`.
1. Set desired manages server count as `server_count` in `vars.tf`.
1. Generate key pair. Set public key value in variable `public_key`
   in `keys.tf`. Set filename of private key in `vars.tf` as `private_key_file`.
1. Make sure project quota allows for the required amount of floating IPs.

## Init, plan and apply

As usual, execute
```
terraform init
terraform plan
terraform apply
```
Note you may need a VPN to install Terraform providers.

After execution if successful find the `file/ssh_config`.
You may use it to connect to the project servers like
```
ssh -F files/ssh_config server-0
```

## Ansible

Ansible configuration is under the `./ansible/` folder.
Terraform writes inventory in the `./ansible/inventory/hosts` file.

To execute Ansible, change directory to `./ansible/` as follows:
```
cd ansible/
ansible -m ping all
```
Output:
```
server-0 | SUCCESS => {
...
    "ping": "pong"
}
```

## Caveats

https://releases.hashicorp.com/terraform/ is blocking access (from Russia?).
