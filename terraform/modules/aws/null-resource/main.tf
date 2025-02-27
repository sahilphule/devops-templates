resource "null_resource" "null-resource" {
  count = var.null-resource-properties.null-resource-count

  provisioner "local-exec" {
    command = var.null-resource-properties.null-resource-local-exec-command[count.index]
  }
}
