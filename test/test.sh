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
    rm -rf "$TMPBASE"
}

Run ()
{
    echo "$*"
    shift
    eval "$@"
}

trap AtExit 0 1 2 3 15

# #######################################################################

archive=archive.run

mkdir -p "$TMPBASE"
( cd "$TMPBASE" && touch start.sh 2 3 4 5 ; chmod 755 start.sh )

Run "%% TEST create:" makeself --nowait --nomd5 --nocrc --nox11 --nocomp \
    "$TMPBASE" $archive label echo

pwd
ls -la $archive
file $archive

Run "%% TEST run:" ./$archive

rm -f $archive

# End of file
