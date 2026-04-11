choco install tfsec
tfsec --config-file tfsec.yml

tfsec .
tfsec /src/tf/dev

tfsec --workspaces development .
