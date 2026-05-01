## mydotfiles
My dotfiles is  backup
- i3-wm 
- rofi
- ranger 
- nvim 
- feh
- polybar

## Justfile Commands
This project includes a `justfile` for common tasks. Install [just](https://github.com/casey/just) first.

### Config Sync
- `just sync-bashrc` - sync .bashrc to home directory
- `just sync-tmux` - sync tmux.conf to home directory
- `just sync-configs` - sync both .bashrc and tmux.conf

### Dotfiles Management
- `just update-dotfiles` - commit all dotfiles changes
- `just push-dotfiles` - push to remote
- `just pull-dotfiles` - pull latest changes
- `just install-dotfiles` - symlink dotfiles to home

### Other Utilities
Run `just --list` to see all available recipes.

## add ppa  i3-wm on ubuntu 21.04 
```
  sudo add-apt-repository ppa:regolith-linux/release
  sudo apt update
  sudo apt install i3-gaps
```
### polybar-themes 
```
https://github.com/adi1090x/polybar-themes
```
### wallpappers

```
git clone https://github.com/makccr/wallpapers`
```
### spacevim 
```
curl -sLf https://spacevim.org/install.sh | bash
```

### install  vim-plug
if use vim 
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### ranger icon file 

```
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

```

### add paa alacritty termail 

```
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt install alacritty
```

### terminator-themes
```
https://github.com/EliverLara/terminator-themes
```

### xcwd - X current working directory
```
sudo apt install xcwd
```
