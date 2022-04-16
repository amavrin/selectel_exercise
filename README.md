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
