ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="gnzh"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Disable marking untracked files under VSC
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ZSH
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git tmux sudo zsh-syntax-highlighting)

# SOURCES
source $ZSH/oh-my-zsh.sh
# common usefull functions
source $HOME/zshcommon.sh
source $HOME/tools/tools.sh
# aliases
source $HOME/zshaliases.sh

# PATH
export PATH=$HOME/local/bin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$(clear_path $PATH)  # Remove duplicates
export LANG="en_US.UTF-8"

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

export SHELL=$(which zsh)

export TERM='xterm-256color'

export GOROOT=/usr/lib/go
export GOBIN=/usr/bin/go

export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$(clear_path $LD_LIBRARY_PATH)
export PIP2EVAL_TMP_FILE_PATH=$HOME/tmp

# Predictable SSH authentication socket location.
SOCK="/tmp/ssh-agent-$USER-tmux"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-tmux
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

export EDITOR=$(which vim)

#alias urldecode=python -c "import sys, urllib; print urllib.unquote_plus(str(sys.stdin.read())"
#alias urlencode=python -c "import sys, urllib; print urllib.quote(sys.stdin.read())"

urlencode() {
    # urlencode <string>

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            ' ') printf + ;;
            *) printf '%%%X' "'$c"
        esac
    done
}

urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\x}"
}
