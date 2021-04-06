### Set environment variables
define HELP_TEXT
Usage: make [TARGET] env=[dev|prod]
Available targets:
endef

export HELP_TEXT

help: ## help target
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
                {printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## sam build
	sam build --config-env dev -u 
	
validate: ## Validated CloudFormation Templates...
validate: build
	docker run -ti --rm -v $(CURDIR):/data -w /data alpine/cfn-lint template.yaml
	sam local invoke -e events/event.json
	
local_invoke:  ## local invoke testing. Function name is "HelloWorldFunction", 
local_invoke: build
	sam local invoke "HelloWorldFunction"

deploy: ## Deploy codes. Usage example: make deploy env=dev
deploy: build
	sam deploy --config-env $(env) --no-fail-on-empty-changeset

destroy: ## Destroy the cloudformation stack. Usage example: make destory
	aws cloudformation delete-stack --stack-name hello-world
