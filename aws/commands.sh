aws configure
aws configure sso

df -h

aws eks --region <region-name> update-kubeconfig --name <cluster-name>

aws sns publish --topic-arn <sns-topic-arn> --message 'Hello, this is a test sms, email from SNS!'

aws sns publish --phone-number "<phone-number>" --message "Test Message"

aws ses send-email --from sender@example.com --destination file://destination.json --message file://message.json

# for powershell
aws ses send-templated-email --source "sender@gmail.com" --destination '{\"ToAddresses\":[\"receiver@gmail.com\"]}' --template "<email-template-name>" --template-data '{\"name\": \"Sahil\"}'

# SES Domain Verfication Status
aws ses get-identity-dkim-attributes --identities yourdomain.com

# zip folder
zip -r ./<zipped-folder-name>.zip <folder-name>

# zip files directly into root zip folder
zip -r ../lambda-function.zip .
