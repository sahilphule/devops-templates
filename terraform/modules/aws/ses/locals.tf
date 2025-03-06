locals {
  ses-properties = {
    ses-configuration-set-count = 1
    ses-configuration-set-name  = "ses-configuration-set"

    ses-event-destination-name                                  = "cloudwatch-ses-event-destination"
    ses-event-destination-enabled                               = true
    ses-event-destination-matching_types                        = ["send", "delivery", "bounce", "complaint", "reject"]
    ses-event-destination-cloudwatch-destination-default-value  = "SES Monitoring" # default 
    ses-event-destination-cloudwatch-destination-dimension-name = "SESMetric"      # dimension
    ses-event-destination-cloudwatch-destination-value-source   = "messageTag"     # emailHeader, linktag

    ses-email-identity-count = 2
    ses-emails               = ["example-1@gmail.com", "example-2@gmail.com"]

    ses-template-count         = 1
    ses-template-name          = "ses-template-name"
    ses-template-subject       = "Welcome to Our Service, {{name}}!" # Dynamic placeholder
    ses-template-html-filename = "../../../configs/ses-templates/email-template.html"
    ses-template-text-filename = "../../../configs/ses-templates/email-template.txt"

    ses-domain-identity-count  = 1
    ses-domain-identity-domain = "codecoords.com"
  }
}
