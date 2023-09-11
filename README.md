<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_keycloak"></a> [keycloak](#requirement\_keycloak) | 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_keycloak"></a> [keycloak](#provider\_keycloak) | 2.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [keycloak_group.project_group](https://registry.terraform.io/providers/mrparkers/keycloak/2.0.0/docs/resources/group) | resource |
| [keycloak_group.role_groups](https://registry.terraform.io/providers/mrparkers/keycloak/2.0.0/docs/resources/group) | resource |
| [keycloak_group.tenant_group](https://registry.terraform.io/providers/mrparkers/keycloak/2.0.0/docs/data-sources/group) | data source |
| [keycloak_realm.realm](https://registry.terraform.io/providers/mrparkers/keycloak/2.0.0/docs/data-sources/realm) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_login_url"></a> [custom\_login\_url](#input\_custom\_login\_url) | URL of custom login page/app. | `string` | `null` | no |
| <a name="input_kc_base_url"></a> [kc\_base\_url](#input\_kc\_base\_url) | Base URL of KeyCloak instance to interact with. | `string` | n/a | yes |
| <a name="input_kc_iam_auth_client_id"></a> [kc\_iam\_auth\_client\_id](#input\_kc\_iam\_auth\_client\_id) | Client ID of client where KC roles corresponding to AWS roles will be created. | `string` | n/a | yes |
| <a name="input_kc_realm"></a> [kc\_realm](#input\_kc\_realm) | KeyCloak realm where terraform client has been created and where users/groups to be created/manipulated exist. | `string` | n/a | yes |
| <a name="input_kc_terraform_auth_client_id"></a> [kc\_terraform\_auth\_client\_id](#input\_kc\_terraform\_auth\_client\_id) | Client ID of client that terraform will authenticate against in order to do its work. | `string` | n/a | yes |
| <a name="input_kc_terraform_auth_client_secret"></a> [kc\_terraform\_auth\_client\_secret](#input\_kc\_terraform\_auth\_client\_secret) | Client secret used by Terraform KeyCloak provider authenticate against KeyCloak. | `string` | n/a | yes |
| <a name="input_project_accounts"></a> [project\_accounts](#input\_project\_accounts) | A map of the project accounts (with structure matching output of aws\_organizations\_account) for which we will be creating roles and IDP resources, keyed by the name of the envrionment. | `map(any)` | n/a | yes |
| <a name="input_project_spec"></a> [project\_spec](#input\_project\_spec) | List of projects/(accounts) that product teams' workloads run within. | <pre>object({<br>    identifier = string<br>    name       = string<br>    tags = object({<br>      account_coding = string<br>      # ministry_name       = string<br>      admin_contact_email = string<br>      admin_contact_name  = string<br>      billing_group       = string<br>      additional_contacts = optional(list(object({<br>        name  = optional(string, null)<br>        email = optional(string, null)<br>      })))<br>    })<br>    accounts = list(object({<br>      name        = string<br>      environment = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_tenancy_root_group_name"></a> [tenancy\_root\_group\_name](#input\_tenancy\_root\_group\_name) | n/a | `string` | `"Project Team Groups"` | no |
| <a name="input_workload_account_role_config"></a> [workload\_account\_role\_config](#input\_workload\_account\_role\_config) | A mapping of role names to be created to (existing) policy arns. | <pre>list(object({<br>    aws_role_name       = string<br>    aws_policy_arns     = list(string)<br>    keycloak_group_name = string<br>    environments        = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->