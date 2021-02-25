# sam-hello-world

This is a template project to give the instruction on how to deploy Cloudformation stack with AWS SAM CLI, it does not only cover serverless projects, it should be widely applied to any Cloudformation templates deployment.

### Two reasons to go with SAM CLI

If you know terraform, another IaC tool, I am fully enjoy with this tool to manage the infrastructure deployment on Clouds, but when deal with Lambda functions, it is not good enough, especially it doesn't have `package` feature as in AWS CLI and AWS SAM CLI. 

If you still deploy cloudformation templates with AWS CLI, then you know you have to write a lot of scripts to run these AWS CLI. You should try to use this template to deploy your cloudformation stacks with AWS SAM CLI.

### Get help

```
$ make help
Usage: make [TARGET] env=[dev|prod]
Available targets:
help                            help target
validate                        Validated CloudFormation Templates...
deploy                          Deploy codes. Usage example: make deploy env=dev
destroy                         Destroy the cloudformation stack. Usage example: make destory
```
### Deploy the sample application

To build and deploy your application for the first time, run the following in your shell:

```
# deploy codes for dev environment
$ make deploy env=dev
```

### Understand SAM CLI Configuration file

Default SAM CLI configuration file is `samconfig.toml`, you can use it define stack name, s3 bucket name, parameter overrides (not sensitive)

If you need SAM to read the configuration, use option --config-env

```
sam deploy --config-env dev
```

### Manage sensitive parameters.

Don't save any sensitive password, api key, secrets in `samconfig.toml`, let the lambda function to get the value from AWS SSM Parameter store with `SecureString`

You just need set the SSM key name as parameter in the template. Let the function to get the value from SSM. It runs inside of lambda function, and has no chance to expose the secrets 

### Cleanup

To delete the sample application that you created, use the AWS CLI. Assuming you used your project name for the stack name, you can run the following:

```bash
make destory
```

### pipeline management

In this sample, we manage two branches, `develop` and `master`, anytime, do coding on feature branches only, such as feature/abc-1234, bugfix/abc-342, hotfix/des-234, etc. Then raise pull request to `develop` branch, after reviewed, raise pull request to `master` branch.

The Circle CI pipeline will run the build and deployment as below

1) (CI stage) any branches: run build and validation
2) (CD stage for Dev) `develop` branch: run build, validation and directly to develop environment
3) (CD stage for Prod) `master` branch: run build, validatation, wait for approve, then deploy to production environment.

NOTES: the pipeline stages are generic, should be applied to any CICD tools.

## Resources

See the [AWS SAM developer guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) for an introduction to SAM specification, the SAM CLI, and serverless application concepts.

Next, you can use AWS Serverless Application Repository to deploy ready to use Apps that go beyond hello world samples and learn how authors developed their applications: [AWS Serverless Application Repository main page](https://aws.amazon.com/serverless/serverlessrepo/)
