from ez_setup import use_setuptools
use_setuptools()
from setuptools import setup, find_packages
from distutils import log

from celerid.support import setup, Extension
import celerid, setuptools
import os.path, glob

log.set_verbosity(100)

prisnif_sources1 =glob.glob('src/icc/atp/src/*.d')
prisnif_sources2 = glob.glob('submodules/prisnif/*.d')
prisnif_sources2 = [s for s in prisnif_sources2
                 if not
                 (
                     s.endswith('main.d')
                 )
]

prisnif_sources=prisnif_sources1 + prisnif_sources2

setup(
    zip_safe = True,
	name="icc.atp",
	version="0.0.2",
	author="Evgeny Cherkashin",
	author_email="eugeneai@irnok.net",
	description="Automatic Theorem Proving wrapper for Python",

    packages=find_packages("src"),
    package_dir={"": "src"},
    namespace_packages=["icc"],

    install_requires=[
        "setuptools",
        "celerid",
    ],

	ext_modules=[
        Extension("icc.atp.atp",
            sources=prisnif_sources,
        )
	],

    license = "GNU GPL",
    keywords = "automatic theorem proving ATP proof first-order logics",

    long_description = """ """,

    # platform = "Os Independent.",
    # could also include long_description, download_url, classifiers, etc.

)
