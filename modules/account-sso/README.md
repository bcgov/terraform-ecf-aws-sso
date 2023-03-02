<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.56.0 |
| <a name="requirement_keycloak"></a> [keycloak](#requirement\_keycloak) | 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.56.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_keycloak"></a> [keycloak](#provider\_keycloak) | 2.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.bcgov_perm_boundary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.role-policy-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_saml_provider.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.aws_context](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [http_http.saml_idp_metadata](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [keycloak_realm.kc-lz-sso-realm](https://registry.terraform.io/providers/mrparkers/keycloak/2.0.0/docs/data-sources/realm) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Name to identify the account. | `string` | n/a | yes |
| <a name="input_account_roles"></a> [account\_roles](#input\_account\_roles) | Roles and associated policies for an account. | `map(string)` | n/a | yes |
| <a name="input_aws_saml_idp_name"></a> [aws\_saml\_idp\_name](#input\_aws\_saml\_idp\_name) | Name for Keycloak IDP that will be created in AWS | `string` | n/a | yes |
| <a name="input_kc_base_url"></a> [kc\_base\_url](#input\_kc\_base\_url) | Base URL of KeyCloak instance to interact with. | `string` | n/a | yes |
| <a name="input_kc_iam_auth_client_id"></a> [kc\_iam\_auth\_client\_id](#input\_kc\_iam\_auth\_client\_id) | Client ID of client where KC roles corresponding to AWS roles will be created. | `string` | n/a | yes |
| <a name="input_kc_realm"></a> [kc\_realm](#input\_kc\_realm) | KeyCloak realm where terraform client has been created and where users/groups to be created/manipulated exist. | `string` | n/a | yes |
| <a name="input_trusted_login_sources"></a> [trusted\_login\_sources](#input\_trusted\_login\_sources) | A list of one or more URLs from which login is expected and permitted. | `list(string)` | <pre>[<br>  "https://signin.aws.amazon.com/saml"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->