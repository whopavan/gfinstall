# Google Fonts Installer (gfinstall)
GFInstall is a simple shell script that helps to install google fonts directly from your terminal. When you press tab it tries to auto-complete the font name you're looking for.

### Install
```
sudo add-apt-repository ppa:realpvn/gfinstall
sudo apt update
sudo apt install gfinstall
```

### Run
```
gfinstall poppins
```

### Usage & options
```
Usage:
gfinstall [options] [fontNameHere]

Options:
-l   |  --local            To Install fonts locally
-v   |  --version          Check gfinstall version
-ul  |  --update-list      To update local google font list (this helps autocompletion)
-h   |  --help             Displays available options

Examples:
gfinstall montserrat              # installs montserrat font globally
gfinstall --local ubuntu          # installs ubuntu font locally
gfinstall -v                      # to check gfinstall version
```
By default fonts will be installed globally (`/usr/share/fonts/`), if you want to install it only for the current user then use `-l` or `--local` flag

### Supported
- Ubuntu (20.04)

I will update supported list when I test on multiple platforms
