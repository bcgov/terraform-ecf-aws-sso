data "keycloak_realm" "kc-lz-sso-realm" {
  realm = var.kc_realm
}

data "http" "saml_idp_metadata" {
  url = "${var.kc_base_url}/auth/realms/${var.kc_realm}/protocol/saml/descriptor"
}

resource "aws_iam_saml_provider" "default" {
  name                   = var.aws_saml_idp_name
  saml_metadata_document = data.http.saml_idp_metadata.response_body
}

data "aws_caller_identity" "aws_context" {}

resource "aws_iam_role" "role" {
  for_each = var.account_roles

  name                 = each.key
  max_session_duration = 21600
  permissions_boundary = aws_iam_policy.bcgov_perm_boundary.arn
  managed_policy_arns  = each.value
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.aws_context.account_id}:saml-provider/${var.aws_saml_idp_name}"
      },
      "Action": "sts:AssumeRoleWithSAML",
      "Condition": {
        "StringEquals": {
          "SAML:aud": ${jsonencode(var.trusted_login_sources)}
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "bcgov_perm_boundary" {
  name        = "BCGOV_Permission_Boundary_v2"
  description = "Policy to restrict actions on BCGov Resources"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "*"
        Effect   = "Allow"
        Resource = "*"
        Sid      = "AllowAdminAccess"
      },
      {
        Action   = "iam:*Provider"
        Effect   = "Deny"
        Resource = "*"
        Sid      = "DenyPermBoundaryBCGovIDPAlteration"
      },
      {
        Action   = "elasticloadbalancing:DeleteLoadBalancer"
        Effect   = "Deny"
        Resource = "arn:aws:elasticloadbalancing:ca-central-1:*:loadbalancer/app/default/*"
        Sid      = "DenyPermBoundaryALBAlteration"
      },
      {
        Action = [
          "iam:Create*",
          "iam:Update*",
          "iam:Delete*",
          "iam:DetachRolePolicy",
          "iam:DeleteRolePolicy"
        ]
        Effect = "Deny"
        Resource = [
          "arn:aws:iam::*:policy/BCGOV*",
          "arn:aws:iam::*:role/CloudCustodian",
          "arn:aws:iam::*:role/AWSCloudFormationStackSetExecutionRole",
          "arn:aws:iam::*:role/*BCGOV*",
          "arn:aws:iam::*:instance-profile/EC2-Default-SSM-AD-Role-ip"

        ]
        Sid = "DenyPermBoundaryBCGovAlteration"
      },
      {
        Action = [
          "budgets:DeleteBudgetAction",
          "budgets:UpdateBudgetAction",
          "budgets:ModifyBudget"
        ]
        Effect   = "Deny"
        Resource = "arn:aws:budgets::*:budget/Default*"
        Sid      = "DenyDefaultBudgetAlteration"
      },
      {
        Action = [
          "iam:DeleteInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile"
        ]
        Effect   = "Deny"
        Resource = "arn:aws:iam::*:instance-profile/EC2-Default-SSM-AD-Role-ip"
        Sid      = "DenyDefaultInstanceProfileAlteration"
      },
      {
        Action = [
          "kms:ScheduleKeyDeletion",
          "kms:DeleteAlias",
          "kms:DisableKey",
          "kms:UpdateAlias"
        ]
        Effect   = "Deny"
        Resource = "*"
        Condition = {
          "ForAnyValue:StringEquals" = {
            "aws:ResourceTag/Accelerator" = "PBMM"
          }
        }
        Sid = "DenyDefaultKMSAlteration"
      },
      {
        Action = [
          "ssm:DeleteParameter*",
          "ssm:PutParameter"
        ],
        Effect = "Deny",
        "Resource" : [
          "arn:aws:ssm:*:*:parameter/cdk-bootstrap/pbmmaccel/*",
          "arn:aws:ssm:*:*:parameter/octk/*"
        ],
        Sid = "DenyDefaultParameterStoreAlteration"
      },
      {
        Action = [
          "secretsmanager:DeleteSecret",
          "secretsmanager:CreateSecret",
          "secretsmanager:UpdateSecret"
        ]
        Effect   = "Deny"
        Resource = "arn:aws:secretsmanager:*:*:secret:accelerator*"
        Sid      = "DenyDefaultSecretManagerAlteration"
      }
    ]
  })
}
