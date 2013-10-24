.PHONY: setup clean
DFLAGS="-Isrc/icc/atp/src"
setup: setup.py
	python setup.py develop

clean:
	python setup.py clean --all
