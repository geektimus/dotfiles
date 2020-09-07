if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# TODO: Move the custom scripts to $HOME/.local/bin
export USERBIN=$HOME/.bin:$HOME/.local/bin
export PATH=$PATH:$USERBIN

# export JAVA_HOME=/usr/lib/jvm/default
export JAVA_HOME=/usr/local/share/development/java/latest
export PATH=$JAVA_HOME/bin:$PATH

export SBT_HOME=/usr/local/share/development/sbt/latest
export PATH=$PATH:$SBT_HOME/bin

export HADOOP_HOME=/tmp/hadoop/

export AMMONITE_HOME=/usr/local/share/development/ammonite
export PATH=$PATH:$AMMONITE_HOME

export KUBECTL_HOME=/usr/local/share/development/kubernetes
export PATH=$PATH:$KUBECTL_HOME

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/geektimus/.sdkman"
[[ -s "/home/geektimus/.sdkman/bin/sdkman-init.sh" ]] && source "/home/geektimus/.sdkman/bin/sdkman-init.sh"

export GOPATH=$HOME/Projects/personal/language/go

export PATH=$PATH:$GOPATH/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$PATH:$HOME/.local/share/coursier/bin"

export CONSCRIPT_HOME=$HOME/.conscript
export PATH=$PATH:$CONSCRIPT_HOME/bin

export PATH=$HOME/.fnm:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Config location for bspwm
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
