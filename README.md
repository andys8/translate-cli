# translate-cli

Command Line Interface to translate words.
The current translation supports german and english words. Input will be translated in both directions.

```sh
➜  ~ translate golden
[en] golden
[en] gold
[en] or
[en] aureate
[en] gilded
[de] golden
[de] goldgelb
[de] goldig
[de] Goldfarbe
[de] goldene Farbe
```

## Initial setup

`stack setup`

## Build

`stack build`

## Run

### NPM

* `npm i -g @andys8/translate-cli`
* `translate <text-to-translate>`

### Binary

* Download compressed binary
    * [Linux](https://github.com/andys8/translate-cli/raw/master/bin/x86_64-linux/translate.tgz)
    * [OSX](https://github.com/andys8/translate-cli/raw/master/bin/x86_64-osx/translate.tgz)
* Add manually to `PATH`
* `translate <text-to-translate>`

### Build from sources

* Setup stack
* `stack exec translate -- <text-to-translate>` to translate


## Credits

[Glosbe API](https://de.glosbe.com/a-api) is used for translation.
