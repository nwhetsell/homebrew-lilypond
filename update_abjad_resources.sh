#!/bin/sh

brew update-python-resources \
  --exclude-packages $(echo "
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
    sphinxcontrib-serializinghtml" | tr -d '[:blank:]') \
  abjad
