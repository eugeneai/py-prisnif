from ez_setup import use_setuptools
use_setuptools()
from setuptools import setup, find_packages
from distutils import log

from celerid.support import setup, Extension
import celerid, setuptools
import os.path

log.set_verbosity(100)


prisnif_sources="""answer.d gterm.d misc.d
  parserhu.d pchunk.d prisnif.d
  proofnode.d qformulas.d
  question.d supervisor.d symbol.d
  """.split()
prisnif_src_location="submodules/prisnif/"
prisnif_sources=[os.path.join(prisnif_src_location, f) for f in prisnif_sources]


print "Prisnif:", prisnif_sources


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
                  sources=["src/icc/atp/src/atp.d",
                    ] + prisnif_sources,
                  include_dirs=[prisnif_src_location],
        )
	],

    license = "GNU GPL",
    keywords = "automatic theorem proving ATP proof first-order logics",

    long_description = """ """,

    # platform = "Os Independent.",
    # could also include long_description, download_url, classifiers, etc.

)
