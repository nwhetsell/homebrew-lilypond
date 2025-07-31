#!/bin/sh

set -e

excluded_packages="\
alabaster,\
black,\
pygments,\
requests,\
roman-numerals-py,\
snowballstemmer,\
sphinxcontrib-applehelp,\
sphinxcontrib-devhelp,\
sphinxcontrib-htmlhelp,\
sphinxcontrib-jsmath,\
sphinxcontrib-qthelp,\
sphinxcontrib-serializinghtml\
"

brew update-python-resources --exclude-packages "${excluded_packages}" abjad
