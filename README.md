# Google Fonts Installer (gfinstall)
GFInstall is a simple shell script that helps to install google fonts directly from your terminal. When you press tab it tries to auto-complete the font name you're looking for.

### Install
```
sudo apt update

# Run below command for minimal ubuntu installations only (ex: ubuntu docker image)
sudo apt install software-properties-common

sudo add-apt-repository ppa:realpvn/gfinstall
sudo apt install gfinstall
```

### Run
```
gfinstall {fontNameHere}
```

### Auto Completion in ZSH
If you are using zsh as your main shell, you might want to run below commands to get gfinstall autocompletions working for you.<br>

First 2 lines enables bash script completion compatibility mode in zsh, last line will source gfinstall autocompletion script. You can add this to your `~/.zshrc` file so everytime you open new shell you have gfinstall autocompletions working
```
autoload bashcompinit
bashcompinit
source /usr/share/bash-completion/completions/gfinstall.bash
```

### Usage & options
By default fonts will be installed globally (`/usr/share/fonts/`), if you want to install it only for the current user then use `-l` or `--local` flag.
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

### Currently Supported
- Ubuntu (20.04)
