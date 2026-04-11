vault token lookup

vault --version
vault server -dev
vault status

$env:VAULT_ADDR="http://127.0.0.1:8200"
$env:VAULT_TOKEN=""

vault secrets list
vault secrets disable <path>

---

# local key value vault
vault secrets enable -path=<path> kv
vault kv list secret/
vault kv put <path/sub-path> <key>=<value>
vault kv get <path/sub-path>
vault kv get -format=json <path/sub-path>
vault kv delete <path/sub-path>
vault kv destroy -versions=1 secret/appdev-kv/appcreds

---

# AWS
vault secrets enable -path=aws aws

# configure aws vault with aws account using root access & secret keys
vault write aws/config/root \
access_key=<aws-access-key> \
secret_key=<aws-secret-key> \
region=<aws-region>

# create the aws iam role
vault write aws/roles/<role-name> \
        credential_type=iam_user \
        policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1426528957000",
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF

# generate the access & secret keys for the role
vault read aws/creds/<role-name>
vault lease revoke <lease-id>

---

# auth commands
vault auth list
vault auth enable userpass
vault write auth/userpass/users/<username> password=<"password"> policies=<"policy-name">
vault login -method="userpass" username=<"username"> password=<"password">

---

# policy commands
vault policy list
vault policy write <policy-name> <policy-file-path>
vault policy read <policy-name>
vault policy delete <policy-name>
vault token create -field token -policy=<policy-name>
$VAULT_TOKEN="$(vault token create -field token -policy=test-policy)"

vault kv put -mount=<path> <sub-path> <key>=<value>
vault kv metadata get -mount=<path> <sub-path>
vault kv get -mount=<path> -version=<version-number> <sub-path>

---
