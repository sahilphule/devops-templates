data "local_file" "ses-template-html-file" {
  count = var.ses-properties.ses-template-count

  filename = var.ses-properties.ses-template-html-filename[count.index]
}

data "local_file" "ses-template-text-file" {
  count = var.ses-properties.ses-template-count

  filename = var.ses-properties.ses-template-text-filename[count.index]
}
