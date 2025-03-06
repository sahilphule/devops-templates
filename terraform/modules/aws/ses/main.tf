resource "aws_ses_configuration_set" "ses-configuration-set" {
  count = var.ses-properties.ses-configuration-set-count

  name                       = var.ses-properties.ses-configuration-set-name
  reputation_metrics_enabled = true
  sending_enabled            = true
}

resource "aws_ses_event_destination" "ses-event-destination" {
  count = var.ses-properties.ses-configuration-set-count

  name                   = var.ses-properties.ses-event-destination-name
  configuration_set_name = aws_ses_configuration_set.ses-configuration-set[count.index].name
  enabled                = var.ses-properties.ses-event-destination-enabled
  matching_types         = var.ses-properties.ses-event-destination-matching-types

  cloudwatch_destination {
    default_value  = var.ses-properties.ses-event-destination-cloudwatch-destination-default-value
    dimension_name = var.ses-properties.ses-event-destination-cloudwatch-destination-dimension-name
    value_source   = var.ses-properties.ses-event-destination-cloudwatch-destination-value-source
  }
}

resource "aws_ses_email_identity" "ses-email-identity" {
  count = var.ses-properties.ses-email-identity-count

  email = var.ses-properties.ses-emails[count.index]
}

resource "aws_ses_template" "ses-template" {
  count = var.ses-properties.ses-template-count

  name    = var.ses-properties.ses-template-name[count.index]
  subject = var.ses-properties.ses-template-subject[count.index]
  html    = data.local_file.ses-template-html-file[count.index].content
  text    = data.local_file.ses-template-text-file[count.index].content
}

resource "aws_ses_domain_identity" "ses-domain-identity" {
  count = var.ses-properties.ses-domain-identity-count

  domain = var.ses-properties.ses-domain-identity-domain
}

resource "aws_ses_domain_dkim" "ses-domain-dkim" {
  count = var.ses-properties.ses-domain-identity-count

  domain = aws_ses_domain_identity.ses-domain-identity[count.index].domain
}
