#!/bin/bash -i
[[ -z "$TOPSHDIR" ]] && export TOPSHDIR=`dirname $(realpath $0)`
. $TOPSHDIR/funcs.sh
[[ "$PWD" != "$TOPSHDIR" ]] && cd $TOPSHDIR

log Updating and building "isl" ...
./isl.sh
cd $TOPSHDIR
log Updating and building "osl" ...
./osl.sh
cd $TOPSHDIR
log Updating and building "cloog" ...
./cloog.sh
cd $TOPSHDIR
log Updating and building "gmp" ...
./gmp.sh
cd $TOPSHDIR
log Updating and building "mpfr" ...
./mpfr.sh
cd $TOPSHDIR
log Updating and building "mpc" ...
./mpc.sh
cd $TOPSHDIR