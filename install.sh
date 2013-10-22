#!/bin/bash

PYTHON_VERSION=2
PYTHON=python$PYTHON_VERSION
VIRT_PREF="(dme)"

ICC_DME_BRANCH="master"
PYGOBJECT_V="3.8.3"
CAIRO_V="1.10.0"


# DEBUG="1"
DEBUG="" 

git submodule init
git submodule update

cd submodules
cd pyd
python setup.py install
cd ../..

$PYTHON setup.py develop

rm -rf tmp-install