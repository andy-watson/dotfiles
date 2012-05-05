


# Append command history rather than overwrite, verify command
# when using !hist and keep alot of it
shopt -s histappend
shopt -s histverify
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:ignorespace
#
# Lets be clear about umask, not take what has been given to us
# as some system default
umask 0027

# Pretty up the command prompt
PS1='[\u@\h \W]\$ '

# Colours for ls, basically I only want directories and
# specials highlighting (ok and setUID/GID)
LSCOLORS=exfxbxbxxxbxbxababxxxx

# Os specific customisations
case "$OSTYPE" in
    "darwin10.0" | "darwin11")
        # Enthought python
        PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"

        # git
        if [ -d /usr/local/git ]; then
            PATH="/usr/local/git/bin:$PATH"
            MANPATH="/usr/local/git/share/man:$MANPATH"
        fi

        if [ -d /opt/local/bin ]; then      
            PATH="$PATH:/opt/local/bin"
            MANPATH="$MANPATH:/opt/local/man"
        fi
        # For simpl library dependancies ldd -> otool
        alias ldd="otool -L"

        # Use Carbon Emacs app over standard command line version
        if [ -x "/Applications/Emacs.app" ]; then
            alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
        fi

        alias ls='ls -G'
        alias grep='grep --colour=auto'
        ;;
    "linux-gnu")
        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'

        R_LIBS_USER=~/.R/i686-pc-linux-gnu-library/2.14
        ;;
esac

