resource "aws_ses_email_identity" "ses-email-identity" {
  count = var.ses-properties.ses-email-identity-count

  email = var.ses-properties.ses-emails[count.index]
}

resource "aws_ses_template" "ses-template" {
  name    = var.ses-properties.ses-template-name
  subject = var.ses-properties.ses-template-subject
  html    = data.local_file.ses-template-html-file.content
  text    = data.local_file.ses-template-text-file.content
}

resource "aws_ses_configuration_set" "ses-configuration-set" {
  count = 0

  name = "ses-configuration-set"

  delivery_options {
    tls_policy = "Require"
  }
}
