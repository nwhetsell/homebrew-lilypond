# homebrew-lilypond

This is a [Homebrew](https://brew.sh) tap for installing [LilyPond](https://lilypond.org) on macOS. There are also formulae for [Abjad](https://abjad.github.io) and [ly](https://github.com/frescobaldi/python-ly).

To install LilyPond:

1. On macOS Mojave and Big Sur (but not Catalina), you must first install [MacTeX](https://tug.org/mactex/) by running:

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
    brew install nwhetsell/lilypond/lilypond
    ```

You should now be able to run LilyPond:

```sh
lilypond --loglevel=ERROR --output=c-major-scale - <<EOS
\relative { c' d e f g a b c }
EOS
open c-major-scale.pdf
```
