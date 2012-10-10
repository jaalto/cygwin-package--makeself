#!/bin/sh
# Test basic functionality

set -e

proram=$0
TMPDIR=${TMPDIR:-/tmp}
BASE=tmp.$$
TMPBASE=${TMPDIR%/}/$BASE
CURDIR=.

case "$0" in
  */*)
        CURDIR=$(cd "${0%/*}" && pwd)
        ;;
esac

AtExit ()
{
    rm -rf "$TMPBASE.dir" "$TMPBASE"*
}

Run ()
{
    if [ "$1" ]; then		# Empty message, just command to run
	echo "$*"
	shift
    else
	shift
	echo "$*"
    fi

    eval "$@"
}

trap AtExit 0 1 2 3 15

# #######################################################################

dir="$TMPBASE.dir"
archive="$TMPBASE-archive.run"

mkdir -p "$dir"
( cd "$dir" && touch example.sh 1 2 3 ; chmod 755 *.sh )

Run "%% TEST create:" makeself \
 --nowait \
 --nomd5 \
 --nocrc \
 --nox11 \
 --nocomp \
 "$dir" "$archive" archive-label echo

Run "" ls -la "$archive"
Run "" file "$archive"

Run "%% TEST run:" "$archive"

# End of file
