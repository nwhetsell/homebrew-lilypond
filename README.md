# homebrew-lilypond

This was a [Homebrew](https://brew.sh) tap for installing [LilyPond](https://lilypond.org) on macOS. You should install [LilyPond from homebrew/core](https://formulae.brew.sh/formula/lilypond) instead of this tap.

To uninstall everything from this tap, run:

```sh
brew ls --formula --full-name | grep '^nwhetsell/lilypond/' | xargs brew uninstall
```

To untap this tap, run:

```sh
brew untap nwhetsell/lilypond
```

After you’ve untapped this tap, you can reinstall LilyPond by running:

```sh
brew install lilypond
```

To (re)install [ly](https://github.com/frescobaldi/python-ly), run:

```sh
brew install ly
```

To (re)install [Abjad](https://abjad.github.io), follow the instructions at https://abjad.github.io/first_steps/macos.html.
