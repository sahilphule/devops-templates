locals {
  ses-properties = {
    ses-email-identity-count = 2
    ses-emails               = ["example-1@gmail.com", "example-2@gmail.com"]

    ses-template-name          = "ses-template-name"
    ses-template-subject       = "Welcome to Our Service, {{name}}!" # Dynamic placeholder
    ses-template-html-filename = "../../../configs/ses-templates/email-template.html"
    ses-template-text-filename = "../../../configs/ses-templates/email-template.txt"
  }
}
