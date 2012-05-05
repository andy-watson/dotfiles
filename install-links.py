#!/usr/bin/python
############################################################
#
# Install dotfile symlinks
#
############################################################

import os
import sys

#
# The files we want symlinking
#
link_these_dotfiles = [
    "bashrc", "bash_profile",
    "emacs", "emacs.d",
    "screenrc"
]

home_dir = os.getenv("HOME")
cwd_abs = os.getcwd()
if ( not cwd_abs.startswith( home_dir )):
    print "Error: the dotfiles do not lie within your home directory"
    sys.exit( 1 )
cwd_rel = cwd_abs[len(home_dir)+1:]
#print cwd_rel

print "Installing dotfile symlinks"
for dotfile in link_these_dotfiles:
    dotfile_abs = cwd_abs + '/' + dotfile
    dotfile_rel = cwd_rel + '/' + dotfile
    dest = home_dir + '/.' + dotfile

    if ( os.path.exists( dest )):
        if ( os.path.islink( dest )):
            # it might be the link we have put in place, note we
            # have to check for rel/abs paths!
            existing_link = os.path.realpath( dest )
            if ( dotfile_abs != existing_link ):
                print "Error: I will not overwrite an existing link:\n" \
                      "    %s != %s" % ( dotfile_abs, existing_link )
                sys.exit( 1 )
            print "Notice: symlink exists and is good: %s" % dotfile
        else:
            # There is a real file/directory there ... its down
            # to the user to sort that mess out
            print "Error: I will not overwrite an existing file/directory:\n" \
                  "    %s" % dest
            sys.exit( 2 )
    else:
        print "Notice: creating symlink: %s -> %s" % ( dest, dotfile_rel )
        os.symlink( dotfile_rel, dest )
print "completed."
