#!/bin/bash
#
# Wrapper arround editors to try and get to emacsclient ...
# of course its not that simple on all OSes.

case "$OSTYPE" in
    "darwin10.0" | "darwin11" | "darwin12")
        if [ -x "/Applications/Emacs.app" ]; then
            # Carbon emacs ... adjust path so we don't see
            # the default (dumb) one in /usr/bin first.
            #
            # It is actually more broken than it first appears though,
            # there is no 'emacs' in .../MacOS/bin it is .../MacOS/Emacs
            # but we can't pass that to --alternate-editor as it won't
            # get the daemon option. (This is getting really broken isn't it)
            #
            # Adding a link ..../MacOS/bin/emacs -> ..../MacOS/Emacs doesn't
            # work.
            #
            # Creating a script the exec's ..../MacOS/Emacs doesn't work
            #
            # So I've given up :-(
            exec /Applications/Emacs.app/Contents/MacOS/Emacs "$@"
        else
            # No point in emacs client with dumb version
            exec emacs "$@"
        fi
        ;;
    "linux-gnu")
        echo "5"
        exec emacsclient --alternate-editor="" -c "$@"
        ;;
    *)
        echo "6"
        exec emacs "$@"
esac
