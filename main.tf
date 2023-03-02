locals {
  trusted_login_sources = var.custom_login_url == null ? [
    "https://signin.aws.amazon.com/saml"] : [
    "https://signin.aws.amazon.com/saml",
    var.custom_login_url
  ]
  idp_name = "BCGovKeyCloak-${var.kc_realm}-v2"
}

data "keycloak_realm" "realm" {
  realm = var.kc_realm
}

data "keycloak_group" "tenant_group" {
  realm_id = data.keycloak_realm.realm.id
  name     = "Project Team Groups (v2)"
}

resource "keycloak_group" "project_group" {
  realm_id  = data.keycloak_realm.realm.id
  parent_id = data.keycloak_group.tenant_group.id
  name      = "${var.project_spec.identifier} (${var.project_spec.name})"
}

resource "keycloak_group" "role_groups" {
  for_each = toset([for role_spec in var.workload_account_role_config : role_spec.keycloak_group_name])

  realm_id  = data.keycloak_realm.realm.id
  parent_id = keycloak_group.project_group.id
  name      = each.key
}

