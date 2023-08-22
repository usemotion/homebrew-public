# usemotion/public/temporal

This is an exact copy of the `temporal` [Formula](https://github.com/Homebrew/homebrew-core/blob/536909b848c7d3bb6c6c6ba5945dd8abe495bef5/Formula/t/temporal.rb) but with the ability to run as a brew service (based heavily on the [cockroach Formula](https://github.com/cockroachdb/homebrew-tap/blob/master/Formula/cockroach%4022.2.rb))

## Installing temporal

```bash
# uninstall temporal from core tap
brew uninstall temporal --zap
# install temporal from this tap
brew install usemotion/public/temporal
```

## Running temporal

```bash
# run in background
brew services start temporal
# run in foreground
temporal
```
