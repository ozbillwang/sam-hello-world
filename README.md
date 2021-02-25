# sam-hello-world

This is a template project to give the instruction on how to deploy Cloudformation stack with [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html), it does not only cover serverless projects, it should be widely applied to any Cloudformation templates deployment.

### Two reasons to go with SAM CLI

If you know [terraform](https://www.terraform.io/), another IaC tool, I am fully enjoy with this tool to manage the infrastructure deployment on Clouds, but when deal with Lambda functions, it is not good enough, especially it doesn't have `package` feature as in AWS CLI and AWS SAM CLI. 

Another reason is, some companies are only allowed to use AWS cloudformation temlates, not third party tools, then you know you have to write a lot of scripts with AWS CLI commands. You should reference this template to deploy your cloudformation stacks with AWS SAM CLI. It would make your life easier.

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

Todo: auto-discover stack name when destory

### Deploy the sample application

To build and deploy your application, run the following in your shell:

```
# validate (optional)
make validate

# deploy codes for dev environment
$ make deploy env=dev
```

### Understand SAM CLI Configuration file

Default SAM CLI configuration file is `samconfig.toml`, you can use it define stack name, s3 bucket name, parameter overrides (not sensitive), etc

If you need SAM to read the configuration for particular environment, use option --config-env

```
sam deploy --config-env dev
```

### Manage sensitive information

Don't save any sensitive passwords, api keys, secrets in `samconfig.toml`, let the lambda function to get the value from AWS SSM Parameter store with `SecureString`

You just need set the SSM key name as parameter in the template. Let the function to get the value from SSM. It runs inside of lambda function, and has no chance to expose the secrets 

### Cleanup

To delete the sample application that you created, use the AWS CLI. Assuming you used your project name for the stack name, you can run the following:

```bash
make destory
```

### pipeline management

In this sample, we manage two main branches, `develop` and `master`. Anytime, do coding on feature branches only, such as `feature/abc-1234`, `bugfix/abc-342`, `hotfix/des-234`, etc. Then raise pull request to `develop` branch, after reviewed, and merged, the change would be deploy to develop envrionment. If it works fine, raise pull request to merge the codes to `master` branch.

The Circle CI pipeline will run the build and deployment as below

1) (CI stage) any branches: run build and validation
2) (CD stage for Dev) `develop` branch: run build, validation and directly deploy to develop environment
3) (CD stage for Prod) `master` branch: run build, validatation, wait for approve, then deploy to production environment.

NOTES: the pipeline stages are generic, should be applied to any CICD tools.
