#!/bin/bash -i
[[ -z "$TOPSHDIR" ]] && export TOPSHDIR=`dirname $(realpath $0)`
. $TOPSHDIR/funcs.sh
[[ "$PWD" != "$TOPSHDIR" ]] && cd $TOPSHDIR
[[ ! -d binutils ]] && git clone git://sourceware.org/git/binutils-gdb.git binutils && cd binutils || cd binutils && git reset --hard && git pull
log "Cleaning stale object files and distribution files for package 'binutils' ..."
make clean distclean
log "Generating configuration files for 'binutils' ..."
./autogen.sh
log "Configuring for package 'binutils' ..."
# log "./configure --prefix=$CROSS_PREFIX --enable-gold=yes --host=$TRIPLET --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --with-sysroot"
./configure --prefix=$CROSS_PREFIX --enable-gold=yes --build=$HOST_TRIPLET --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --with-sysroot
[[ $? -eq 0 ]] && log "Building package 'binutils' ..." && make -j4 && [[ $? -eq 0 ]] && log "Installing package 'binutils' to $CROSS_PREFIX ..." && make install.all && log "Running tests for package 'binutils' ..." && make -j8 check
