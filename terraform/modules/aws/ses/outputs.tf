output "ses-domain-dkim-tokens" {
  description = "ses domain dkim tokens"
  value       = aws_ses_domain_dkim.ses-domain-dkim[*].dkim_tokens
}
