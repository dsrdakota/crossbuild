#!/bin/bash -i
#BIG TODO
# ADD functions for building each individual package

export TOPSHDIR=`dirname $(realpath $0)`
: >crossbuild.log
[[ "$PWD" != "$TOPSHDIR" ]] && cd $TOPSHDIR
. $TOPSHDIR/funcs.sh
for f in $(find ./ -name *config.cache); do
	rm -f $f
	log "Removed \"$f\"." 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	make -i -s -C `dirname $f` clean distclean 2>/dev/null | tee -a $TOPSHDIR/crossbuild.log
done

set -e

# TOPSHDIR=`echo $0|sed -e {s/\/$(basename $0)//}`
test -n "$DJDIR" || exec 7<&0 </dev/null
exec 6>&1
exec 5>>crossbuild.log
exec 1>&7 2>&7

export CROSS_PREFIX=$HOME
export PREFIX=$CROSS_PREFIX
#TODO add options specifying what to build
log Updating "libs" ... 2>&1 | tee -a $TOPSHDIR/crossbuild.log
# $TOPSHDIR/libs.sh 1>&5 2>&1
$TOPSHDIR/libs.sh 2>&1 | tee -a $TOPSHDIR/crossbuild.log
cd $TOPSHDIR
log Updating and building "binutils" ...  2>&1 | tee -a $TOPSHDIR/crossbuild.log
# $TOPSHDIR/binutils.sh 1>&5 2>&1
$TOPSHDIR/binutils.sh 2>&1 | tee -a crossbuild.log
cd $TOPSHDIR
log Updating and building "gcc" ...  2>&1 | tee -a $TOPSHDIR/crossbuild.log
# $TOPSHDIR/gcc.sh 1>&5 2>&1
$TOPSHDIR/gcc.sh 2>&1 | tee -a $TOPSHDIR/crossbuild.log
cd $TOPSHDIR

log "Finishing up libtool to fix up libraries ..." 2>&1 | tee -a $TOPSHDIR/crossbuild.log
libtool --mode=finish $CROSS_PREFIX  2>&1 | tee -a $TOPSHDIR/crossbuild.log
libtool --mode=finish $CROSS_PREFIX/lib  2>&1 | tee -a $TOPSHDIR/crossbuild.log
libtool --mode=finish $CROSS_PREFIX/include  2>&1 | tee -a $TOPSHDIR/crossbuild.log
echo DONE 2>&1 | tee -a $TOPSHDIR/crossbuild.log
5>&-
7>&-
