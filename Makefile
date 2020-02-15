.PHONY: init
init:
	poetry install

.PHONY: serve
serve:
	poetry run mkdocs serve

.PHONY: build
build:
	poetry run mkdocs build

.PHONY: deploy
deploy:
	poetry run mkdocs gh-deploy
