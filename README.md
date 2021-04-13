# homebrew-lilypond

[![Actions](https://github.com/nwhetsell/homebrew-lilypond/workflows/CI/badge.svg)](https://github.com/nwhetsell/homebrew-lilypond/actions?workflow=CI)

This is a tap for installing [LilyPond](https://lilypond.org) using [Homebrew](https://brew.sh). To use it:

1. Install [MacTeX](https://tug.org/mactex/) by running:

    ```sh
    brew install --cask mactex-no-gui
    ```

    or:

    ```sh
    brew install --cask mactex
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

MacTeX is required to build LilyPond, but not to run it. If you installed MacTeX
using Homebrew, you can uninstall MacTeX by running:

```sh
brew uninstall --cask mactex-no-gui
```

or:

```sh
brew uninstall --cask mactex
```
