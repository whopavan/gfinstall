# Google Fonts Installer (gfinstall)
GFInstall is a simple shell script that helps to install google fonts directly from your terminal. When you press tab it tries to auto-complete the font name you're looking for.

### Install
```
sudo apt update

# For minimal ubuntu installations
sudo apt install software-properties-common

sudo add-apt-repository ppa:realpvn/gfinstall
sudo apt install gfinstall
```

### Run
```
gfinstall {fontNameHere}
```
By default fonts will be installed globally (`/usr/share/fonts/`), if you want to install it only for the current user then use `-l` or `--local` flag.

### Usage & options
```
Usage:
gfinstall [options] [fontNameHere]

Options:
-l   |  --local            To Install fonts locally
-v   |  --version          Check gfinstall version
-h   |  --help             Displays available options

Examples:
gfinstall montserrat                  # installs montserrat font globally
gfinstall --local montserrat          # installs montserrat font locally
gfinstall -v                          # to check gfinstall version
```

### Supported
- Ubuntu (20.04)

I will update supported list when I test on multiple platforms
