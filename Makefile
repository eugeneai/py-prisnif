.PHONY: setup clean
DFLAGS=-I submodules/prisnif
setup: setup.py
	python setup.py develop

clean:
	python setup.py clean --all
