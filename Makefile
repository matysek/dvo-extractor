.PHONY: default style code-style before_commit

default: tests

unit_tests: ## Run all unit tests defined in this project
	export PATH=tools/:$$PATH;export PYTHONDONTWRITEBYTECODE=1;pytest -v -p no:cacheprovider

coverage: ## Calculate unit test code coverage for the whole repository
	export PATH=tools/:$$PATH;export PYTHONDONTWRITEBYTECODE=1;pytest -v -p no:cacheprovider --cov features/

coverage-report: ## Generate HTML pages with unit test code coverage report
	export PATH=tools/:$$PATH;export PYTHONDONTWRITEBYTECODE=1;pytest -v -p no:cacheprovider --cov features/ --cov-report=html

style:	code-style docs-style ## Perform all style checks

code-style: ## Check code style for all Python sources from this repository
	python3 tools/run_pycodestyle.py

ruff: ## Run Ruff linter
	ruff .

docs-style: ## Check documentation strings in all Python sources from this repository
	pydocstyle .

doc-check: ## Run gen_scenario_list.py to generate docs file and compare it to current one
	python3 tools/gen_scenario_list.py > tmp.md
	diff tmp.md docs/scenarios_list.md

shellcheck: ## Run shellcheck
	./shellcheck.sh

before_commit: code-style update-scenarios ruff

help: ## Show this help screen
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}'
	@echo ''
