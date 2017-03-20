#!/bin/sh

TMPF=`mktemp`
wget -qO$TMPF $1 && test -s $TMPF && samlsign -c $2 -f $TMPF && chown $4 $TMPF && mv $TMPF $3
rm -f $TMPF
