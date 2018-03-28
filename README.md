
# Tracker

This is a lightweight time tracker built in crystal.  It logs tracked time to
a sqlite3 database.

Usage:

```bash
track [reason]
```

A timer is started immediately.  Press Ctrl+C to stop the timer and record the
entry.

## Compilation (OSX)

```bash
# install dependencies
brew update && brew install crystal-lang sqlite3

# compile
crystal deps
crystal build track.cr
```
