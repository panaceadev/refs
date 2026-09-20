# 💡 Works on: Linux, Windows Git Bash, WSL Linux
# Add below in ~/.bashrc in Windows
# test -f ~/.bash_aliases && . ~/.bash_aliases

#region Prompt & Utilities

# "\u@\h:\w\$ "
# "\u\w\$ "
# "\u:\W\$ "
export PS1="\[\033[0;32;1m\]\u\[\033[0m\]:\[\033[0;34;1m\]\W\[\033[0m\]\$ "

# print and copy to clipboard
pc() {
    printf '%s\n' "$1"
    if command -v xclip >/dev/null; then printf '%s' "$1" | xclip -sel clip
    else printf '%s' "$1" | clip.exe; fi
}

#endregion

#region Essential

alias c="clear"
alias la="ls -A"
alias lla="ls -lA"
alias rs='exec "$SHELL"'
alias ba="code ~/.bash_aliases"
if [[ "$OSTYPE" == linux* ]]; then
    alias uu="sudo apt update && sudo apt upgrade && sudo apt autoremove --purge && sudo apt autoclean"
fi
# copy absolute path
cpath() {
    pc "$(realpath "${1:-.}")"
}
# copy file content
cfile() {
    if command -v xclip >/dev/null; then xclip -sel clip < "$1"
    else clip.exe < "$1"; fi
}
# open explorer
oe() {
    if grep -qi microsoft /proc/version 2>/dev/null; then
        explorer.exe "$(wslpath -w "$(realpath "${1:-.}")")"
    elif command -v cygpath >/dev/null; then
        explorer.exe "$(cygpath -wa "${1:-.}")"
    else
        (xdg-open "${1:-.}" >/dev/null 2>&1 &)
    fi
}
# to kebab-case
kebab() {
    pc "$(printf '%s' "$*" | LC_ALL=C tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
}
# to snake_case
snake() {
    pc "$(printf '%s' "$*" | LC_ALL=C tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/_/g; s/^_+|_+$//g')"
}
# address (ip) copy
ac() {
    local ip_address="$(curl -s -4 ifconfig.me)"
    pc "$ip_address"
}
# address (ip), location
al() {
    local ip_address token city region country location
    ip_address="$(curl -s -4 ifconfig.me)"
    token="d7de6b0c0e48a6"
    city="$(curl -s "ipinfo.io/$ip_address/city?token=$token")"
    region="$(curl -s "ipinfo.io/$ip_address/region?token=$token")"
    country="$(curl -s "ipinfo.io/$ip_address/country?token=$token")"
    location="$city, $region, $country"
    echo "$ip_address"
    echo "$location"
}

#endregion

#region Git

alias ga="git add ."
alias gc="git commit"
gm() {
    git commit -m "$*"
}
alias gs="git status -u"
gl() {
    git log -"${1:-10}" --decorate --oneline --graph "${@:2}"
}
gll() {
    git log -"${1:-10}" --decorate --oneline --graph --pretty=format:'%C(yellow)%h%Creset %C(cyan)%ad%Creset %C(green)%an%Creset %C(auto)%d%Creset %s' --date=format:"%Y-%m-%d_%H:%M" "${@:2}"
}
gla() {
    git log -"${1:-10}" --decorate --oneline --graph --all "${@:2}"
}
glal() {
    git log -"${1:-10}" --decorate --oneline --graph --all --pretty=format:'%C(yellow)%h%Creset %C(cyan)%ad%Creset %C(green)%an%Creset %C(auto)%d%Creset %s' --date=format:"%Y-%m-%d_%H:%M_%z" "${@:2}"
}

#endregion

#region Docker

alias dcheck="docker ps -a && echo && docker images && echo && docker volume ls && echo && docker network ls && echo && docker system df"

#endregion

#region Directories

alias doc="cd ~/Documents && la"
alias wip="cd ~/Documents/wip && la"
alias gmine="cd ~/Documents/gmine && la"
alias gothers="cd ~/Documents/gothers && la"
alias tst="cd ~/Documents/test && la"
alias temp="cd ~/Documents/temp && la"

#endregion

# ==========================================================================================

