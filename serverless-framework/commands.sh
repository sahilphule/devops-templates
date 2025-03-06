npm i serverless -g

serverless --version
serverless update
serverless # For several templates

serverless create --template aws-nodejs --path my-service # Create a new Serverless project
serverless config credentials --provider aws --key YOUR_ACCESS_KEY --secret YOUR_SECRET_KEY # Configure AWS credentials for deployment

serverless offline # Start API Gateway and Lambda functions locally (requires serverless-offline plugin)
serverless invoke local -f <function-name> # Invoke a function locally for testing

serverless deploy --profile <aws-profile-name> # Deploy the entire service (Lambda, API Gateway, DynamoDB, etc.)
serverless deploy function -f <function-name> # Deploy only a single function
serverless remove # Remove all deployed resources (cleanup AWS environment)

serverless deploy --stage dev # Deploy with a specific stage (e.g., dev, prod)
serverless deploy --region us-east-1 # Deploy to a specific AWS region
serverless remove --stage dev # Remove a specific stage deployment

serverless info # Display information about the deployed service (endpoints, resources, etc.)
serverless print # To see your final serverless.yml configuration after variables are resolved

serverless invoke -f <function-name> # Invoke a deployed Lambda function manually
serverless invoke -f <function-name> --log # Invoke function and display logs
serverless invoke -f <function-name> --data '{"key": "value"}' # Pass input data to the function

serverless logs -f <function-name> # View logs from AWS CloudWatch
serverless logs -f <function-name> --tail # Stream real-time logs from AWS CloudWatch

serverless plugin list # List installed Serverless plugins
serverless plugin search <plugin-name> # Search for Serverless plugins
serverless plugin install -n <plugin-name> # Install a Serverless plugin
serverless plugin uninstall -n <plugin-name> # Uninstall a Serverless plugin
