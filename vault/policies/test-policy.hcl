# path "secret/data/*" {
#     capabilities = ["create", "update"]
# }

path "secret/data/foo" {
    capabilities = ["read"]
}

path "secret/data/bar" {
    capabilities = ["read"]
}

path "secret/data/cube" {
    capabilities = ["read"]
}