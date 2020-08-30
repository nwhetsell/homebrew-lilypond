# homebrew-lilypond

[![Actions](https://github.com/nwhetsell/homebrew-lilypond/workflows/CI/badge.svg)](https://github.com/nwhetsell/homebrew-lilypond/actions?workflow=CI)

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

3. LilyPond requires [Guile](https://www.gnu.org/software/guile/) 1, which is [keg-only](https://docs.brew.sh/FAQ#what-does-keg-only-mean) to avoid conflicting with more recent versions of Guile. For LilyPond to find Guile libraries, you can either run (and add to your .zshrc):

    ```sh
    export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$(brew --prefix guile@1)/lib"
    ```

    or link Guile by running:
    
    ```sh
    brew link --force guile@1
    ```
    
    (You can run `brew unlink guile@1` later if you change your mind.)

You should now be able to run LilyPond:

```sh
lilypond --loglevel=ERROR --output=c-major-scale - <<EOS
\relative { c' d e f g a b c }
EOS
open c-major-scale.pdf
```
