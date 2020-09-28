.PHONY: test
BIN_DIR=$(CURDIR)/$(ENV_NAME)/bin
MAKEFLAGS += --silent

ENV_NAME=env
PY_VERSION=3
PY=python$(PY_VERSION)

default: install

install:
	$(PY) -m venv $(CURDIR)/$(ENV_NAME)
	$(MAKE) pip-requirements

pip-requirements:
	$(BIN_DIR)/pip3 install --upgrade pip wheel setuptools
	$(BIN_DIR)/pip3 install -r $(CURDIR)/requirements.txt

clean:
	rm -rf $(CURDIR)/$(ENV_NAME)

html:
	$(MAKE) install
	echo HTML

serve:
	cd $(CURDIR)/docs && ../$(ENV_NAME)/bin/mkdocs serve
