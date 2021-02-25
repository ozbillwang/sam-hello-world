
validate:
	docker run -ti --rm -v $(CURDIR):/data -w /data alpine/cfn-lint template.yaml
	sam build && sam local invoke -e events/event.json
deploy:
	sam build && sam deploy --config-env $(env) --no-fail-on-empty-changeset
