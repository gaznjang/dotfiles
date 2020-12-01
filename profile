# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH to add sbin
PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"

EDITOR=nvim
VISUAL=$EDITOR
export EDITOR VISUAL

# environment for ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# set date/time display language
export LC_TIME=en_US.UTF-8

if [ -e "${HOME}/.pyenv/bin/pyenv" ]; then
    # Load pyenv automatically
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    # pyenv: for install shared library python
    export PYTHON_CONFIGURE_OPTS="--enable-shared"
fi

# set compiledb
if [ -e "${HOME}/.pyenv/shims/compiledb" ]; then
    eval "$(_COMPILEDB_COMPLETE=source compiledb)"
fi

# for debmake
DEBEMAIL="chia-hsin.chang@host"
DEBFULLNAME="Chia-Hsin Chang"
export DEBEMAIL DEBFULLNAME

# for mc
export HISTCONTROL=ignoreboth
. /usr/lib/mc/mc.sh

# for quilt
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
complete -F _quilt_completion $_quilt_complete_opt dquilt
