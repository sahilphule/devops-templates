devspace use context "$(kubectl config current-context)"
devspace init
devspace dev
devspace dev --var THE_DEV_CONTAINER_IMAGE=<container-base-image-name>
devspace purge
