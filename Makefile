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

validate: ## Validated CloudFormation Templates...
	docker run -ti --rm -v $(CURDIR):/data -w /data alpine/cfn-lint template.yaml
	sam build && sam local invoke -e events/event.json
deploy: ## Deploy codes. Usage example: make deploy env=dev
	sam build && sam deploy --config-env $(env) --no-fail-on-empty-changeset

destroy: ## Destroy the cloudformation stack. Usage example: make destory
	aws cloudformation delete-stack --stack-name hello-world
