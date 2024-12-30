wsl --status
wsl --version

wsl ~
wsl --distribution <distribution-name> --user <user-name>

wsl --list
wsl --list --verbose
wsl --update
wsl --install
wsl --install -d Debian
wsl --set-default <distribution-name>

<distribution-name> config --default-user <username>

wsl --shutdown
wsl --terminate <distribution-name>
wsl --unregister <distribution-name>