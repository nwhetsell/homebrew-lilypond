# homebrew-lilypond

This is a [Homebrew](https://brew.sh) tap for installing the unstable version of [LilyPond](https://lilypond.org). There is also a formula for [Abjad](https://abjad.github.io).

To install the unstable version of LilyPond, run:

```sh
brew install nwhetsell/lilypond/lilypond-unstable
```

To use the unstable version of LilyPond, you can either add it to your `PATH`, or run:

```sh
brew unlink lilypond; brew link lilypond-unstable
```

You should now be able to run the unstable version of LilyPond:

```sh
lilypond --loglevel=ERROR --output=c-major-scale - <<EOS
\relative { c' d e f g a b c }
EOS
open c-major-scale.pdf
```
