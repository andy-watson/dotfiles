#!/bin/bash
#
# Wrapper arround editors to try and get to emacsclient ...
# of course its not that simple on all OSes.

case "$OSTYPE" in
    "darwin10.0" | "darwin11")
        if [ -x "/Applications/Emacs.app" ]; then
            # Carbon emacs ... adjust path so we don't see
            # the default (dumb) one in /usr/bin first.
            #
            # It is actually more broken than it first appears though,
            # there is no 'emacs' in .../MacOS/bin it is .../MacOS/Emacs
            # but we can't pass that to --alternate-editor as it won't
            # get the daemon option. (This is getting really broken isn't it)
            #
            # What I have added is a simple wrapper .../MacOS/bin/emacs
            # that exec's .../MacOS/Emacs
            # exec env PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH" \
            #     emacsclient --alternate-editor="" -c "$@"
            export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
            emacsclient --alternate-editor="" -c "$@"
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
