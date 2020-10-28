# homebrew-lilypond

[![Actions](https://github.com/nwhetsell/homebrew-lilypond/workflows/CI/badge.svg)](https://github.com/nwhetsell/homebrew-lilypond/actions?workflow=CI)
[![Travis CI](https://travis-ci.org/nwhetsell/homebrew-lilypond.svg?branch=master)](https://travis-ci.org/nwhetsell/homebrew-lilypond)

This is a tap for installing [LilyPond](https://lilypond.org) using [Homebrew](https://brew.sh). To use it:

1. Install [MacTeX](https://tug.org/mactex/) by running:

    ```sh
    brew cask install mactex-no-gui
    ```

    or:

    ```sh
    brew cask install mactex
    ```

    or by downloading and running an installer from https://tug.org/mactex/mactex-download.html.

2. Run:

    ```sh
    brew tap nwhetsell/lilypond
    brew install lilypond
    ```

You should now be able to run LilyPond:

```sh
lilypond --loglevel=ERROR --output=c-major-scale - <<EOS
\relative { c' d e f g a b c }
EOS
open c-major-scale.pdf
```
