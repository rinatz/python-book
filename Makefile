.PHONY: init
init:
	pipenv install

.PHONY: build
build:
	pipenv run build

.PHONY: serve
serve:
	pipenv run serve

.PHONY: gh-deploy
gh-deploy:
	pipenv run gh-deploy

.PHONY: repl
repl:
	pipenv run repl
