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
    echo "$*"
    shift
    eval "$@"
}

trap AtExit 0 1 2 3 15

# #######################################################################

archive="$TMPBASE-archive.run"

mkdir -p "$TMPBASE.dir"
( cd "$TMPBASE" && touch example.sh 1 2 3 ; chmod 755 start.sh )

Run "%% TEST create:" makeself \
 --nowait \
 --nomd5 \
 --nocrc \
 --nox11 \
 --nocomp \
 "$TMPBASE" "$archive" label echo

ls -la "$archive"
file "$archive"

Run "%% TEST run:" "$archive"

# End of file
