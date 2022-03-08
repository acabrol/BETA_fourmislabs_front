#references
# https://stackoverflow.com/a/43566158
# https://news.julien-anne.fr/ubuntu-20-04-python3-et-virtualenv-installation-et-erreurs-potentielles/
# https://pypi.org/project/nodeenv/#local-installation

# Makefile default shell is /bin/sh which does not implement source. Changing shell to /bin/bash makes it possible.
SHELL := /bin/bash

all: clean install

install:
	sudo apt-get install virtualenv
	virtualenv ./venv/python
	# Each line of a make recipe is executed by a separate shell, so even if you source the file, the shell that sources it exits before the next line is evaluated.
	# Put both commands on the same line (or use \ to split a single logical line across multiple physical lines) so that both are executed in the same shell. The semicolon is necessary so that the shell doesn't see them as the single command to run.
	source ./venv/python/bin/activate; \
	pip install nodeenv; \
	nodeenv ./venv/node  --node=16.10.0 --npm=6.14.13; \
	. ./venv/node/bin/activate; \
	npm install --force

start:
	source ./venv/python/bin/activate; \
	. ./venv/node/bin/activate; \
	npx ng serve

clean:
	rm -Rf ./venv
