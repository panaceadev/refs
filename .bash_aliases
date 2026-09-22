# Works on: Linux, Windows Git Bash, WSL Linux, headless servers (no clipboard/GUI)
# Add below in ~/.bashrc in Windows
# test -f ~/.bash_aliases && . ~/.bash_aliases

#region Prompt & Utilities

# "\u@\h:\w\$ "
# "\u\w\$ "
# "\u:\W\$ "
# show the hostname over SSH so remote sessions are not mistaken for local ones
if [ -n "$SSH_CONNECTION" ]; then
    PS1="\[\033[0;32;1m\]\u@\h\[\033[0m\]:\[\033[0;34;1m\]\W\[\033[0m\]\$ "
else
    PS1="\[\033[0;32;1m\]\u\[\033[0m\]:\[\033[0;34;1m\]\W\[\033[0m\]\$ "
fi

# write stdin to the clipboard; returns 1 when there is no clipboard (headless server)
clip_in() {
    if command -v clip.exe >/dev/null; then clip.exe
    elif [ -n "$WAYLAND_DISPLAY" ] && command -v wl-copy >/dev/null; then wl-copy
    elif [ -n "$DISPLAY" ] && command -v xclip >/dev/null; then xclip -sel clip
    else return 1; fi
}
# print and copy to clipboard
pc() {
    printf '%s\n' "$1"
    printf '%s' "$1" | clip_in 2>/dev/null || true
}

#endregion

#region Essential

alias c="clear"
alias la="ls -A"
alias lla="ls -lA"
alias rs='exec "$SHELL"'
ba() {
    "${EDITOR:-$(command -v code || echo nano)}" ~/.bash_aliases
}
if [[ "$OSTYPE" == linux* ]]; then
    alias uu="sudo apt update && sudo apt upgrade && sudo apt autoremove --purge && sudo apt autoclean"
fi
# copy absolute path
cpath() {
    pc "$(realpath "${1:-.}")"
}
# copy file content
cfile() {
    [ -f "$1" ] || { echo "cfile: no such file: ${1:-(none)}" >&2; return 1; }
    clip_in < "$1" 2>/dev/null || cat "$1"
}
# open explorer
oe() {
    if grep -qi microsoft /proc/version 2>/dev/null; then
        explorer.exe "$(wslpath -w "$(realpath "${1:-.}")")"
    elif command -v cygpath >/dev/null; then
        explorer.exe "$(cygpath -wa "${1:-.}")"
    elif command -v xdg-open >/dev/null && [ -n "$DISPLAY$WAYLAND_DISPLAY" ]; then
        (xdg-open "${1:-.}" >/dev/null 2>&1 &)
    else
        echo "oe: no graphical session" >&2
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
# the token is from free ipinfo.io account, no need to change
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

