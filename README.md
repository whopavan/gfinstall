# Google Fonts Installer (gfinstall)
GFInstall is a google font installer. You can install google fonts directly from your terminal.

### Install
```
sudo add-apt-repository ppa:realpvn/gfinstall
sudo apt update
sudo apt install gfinstall
```

### Run
```
gfinstall fontNameHere
```

### Usage & options
```
Usage:
gfinstall [options] [fontNameHere]

Options:
-l  |  --local            To Install fonts locally
-v  |  --version          Check gfinstall version
-ul |  --update-list      To update local google font list
-h  |  --help             Displays available options

Examples:
gfinstall montserrat              # installs montserrat font globally
gfinstall --local ubuntu          # install ubuntu font locally
gfinstall -v                      # to check gfinstall version
```
By default fonts will be installed globally (`/usr/share/fonts/`), if you want to install it only for the current (local) user then use `-l` or `--local` flag
