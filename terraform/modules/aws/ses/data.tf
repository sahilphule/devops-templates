data "local_file" "ses-template-html-file" {
  filename = var.ses-properties.ses-template-html-filename
}

data "local_file" "ses-template-text-file" {
  filename = var.ses-properties.ses-template-text-filename
}
