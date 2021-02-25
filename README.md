# sam-hello-world

This project contains source code and supporting files for a serverless application that you can deploy with the SAM CLI. I

The application uses several AWS resources, including Lambda functions and an API Gateway API. These resources are defined in the `template.yaml` file in this project. You can update the template to add AWS resources through the same deployment process that updates your application code.

### Deploy the sample application

To build and deploy your application for the first time, run the following in your shell:

```
# deploy codes for dev environment
$ make deploy env=dev
```

### SAM CLI Configuration file

Default SAM CLI configuration file is `samconfig.toml`, you can use it define stack name, s3 bucket name, parameter overrides (not sensitive)

If you need SAM to read the configuration, use option --config-evn

```
sam deploy --config-env dev
```

###

### Cleanup

To delete the sample application that you created, use the AWS CLI. Assuming you used your project name for the stack name, you can run the following:

```bash
aws cloudformation delete-stack --stack-name sam-app
```

## Resources

See the [AWS SAM developer guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) for an introduction to SAM specification, the SAM CLI, and serverless application concepts.

Next, you can use AWS Serverless Application Repository to deploy ready to use Apps that go beyond hello world samples and learn how authors developed their applications: [AWS Serverless Application Repository main page](https://aws.amazon.com/serverless/serverlessrepo/)
