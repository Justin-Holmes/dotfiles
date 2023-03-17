# dotfiles

My personal dotfiles for macOS.

## Commands

The main tasks are `Makefile` targets. To see the available commands provided by
the `install`, `uninstall`, `update` and `help` scripts run:

```
make help
```

## Migrating to a new machine

1. Setup iCloud
1. Download App store applications
1. Run `xcode-select --install`
1. Install [homebrew][homebrew]
1. Run `brew install git`
1. Run `git clone https://github.com/justin-holmes/dots.git && cd dotfiles`
1. Add the `gitconfig.local` file to the `dots` directory
1. Run `make install`
1. Follow post install instructions (Vim plugins)
1. Install Terminal colors
1. Install [font](https://github.com/adobe-fonts/source-code-pro)
1. Map caps lock to the control key

## Tips

### Git credentials

To setup your git credentials you'll need to add a `.gitconfig.local` file to
your `$HOME` directory and add the following:

```
[user]
  name = YOUR_GIT_AUTHOR_NAME
  email = YOUR_GIT_AUTHOR_EMAIL
  # signingKey = YOUR_GIT_GPG_SIGNING_KEY
[github]
  user = YOUR_GITHUB_USERNAME
```

Note: Git will ignore `*.local` files. The `install`/`uninstall` script
symlinks/removes a `gitconfig.local`.
