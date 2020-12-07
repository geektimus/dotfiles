# General config location
export XDG_CURRENT_DESKTOP=bspwm
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

# qt themeing
export QT_QPA_PLATFORMTHEME=qt5ct

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

export CONSCRIPT_HOME="$HOME/.config/conscript"
export CONSCRIPT_OPTS="-XX:MaxPermSize=512M -Dfile.encoding=UTF-8"
export PATH=$CONSCRIPT_HOME/bin:$PATH

export PATH=$HOME/.fnm:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH=$PATH:$HOME/.emacs.d/bin

# Weechat override default config location
export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat

export CQLSH_HOME=/opt/cqlsh
export PATH=$PATH:$CQLSH_HOME/bin
