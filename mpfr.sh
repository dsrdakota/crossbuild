#!/bin/bash -i
[[ -z "$TOPSHDIR" ]] && export TOPSHDIR=`dirname $(realpath $0)`
. $TOPSHDIR/funcs.sh
[[ "$PWD" != "$TOPSHDIR" ]] && cd $TOPSHDIR
# [[ ! -d mpfr ]] && svn co svn://scm.gforge.inria.fr/svn/mpfr/trunk || cd mpfr && [[ $(svn info -rHEAD --show-item last-changed-revision svn://scm.gforge.inria.fr/svn/mpfr/trunk) -gt $(svn info -rBASE --show-item last-changed-revision) ]] && svn update
[[ ! -d mpfr ]] && git svn clone --minimize-url --prefix=./mpfr svn://scm.gforge.inria.fr/svn/mpfr/trunk mpfr || cd mpfr && [[ $(svn info -rHEAD --show-item last-changed-revision svn://scm.gforge.inria.fr/svn/mpfr/trunk) -gt $(svn info -rBASE --show-item last-changed-revision) ]] && svn update
log "Cleaning stale object files and distribution files for package 'mpc' ..."
make clean distclean
log "Generating configuration files for 'mpfr' ..."
./autogen.sh
log "Configuring for package 'mpfr' ..."
./configure --build=$HOST_TRIPLET --with-gmp=$CROSS_PREFIX --with-gnu-ld=yes --with-sysroot=$CROSS_PREFIX --enable-thread-safe=yes --disable-dependency-tracking --enable-static=yes --enable-shared=no --prefix=$CROSS_PREFIX
[[ $? -eq 0 ]] && log "Building package 'mpfr' ..." && make -j4 && [[ $? -eq 0 ]] && log "Installing package 'mpfr' to $CROSS_PREFIX ..." && make install && log "Running tests for package 'mpfr' ..." && make -j8 check
#--enable-mini-gmp

# `configure' configures MPFR 3.2.0-dev to adapt to many kinds of systems.

# Usage: ./configure [OPTION]... [VAR=VALUE]...

# To assign environment variables (e.g., CC, CFLAGS...), specify them as
# VAR=VALUE.  See below for descriptions of some of the useful variables.

# Defaults for the options are specified in brackets.

# Configuration:
  # -h, --help              display this help and exit
      # --help=short        display options specific to this package
      # --help=recursive    display the short help of all the included packages
  # -V, --version           display version information and exit
  # -q, --quiet, --silent   do not print `checking ...' messages
      # --cache-file=FILE   cache test results in FILE [disabled]
  # -C, --config-cache      alias for `--cache-file=config.cache'
  # -n, --no-create         do not create output files
      # --srcdir=DIR        find the sources in DIR [configure dir or `..']

# Installation directories:
  # --prefix=PREFIX         install architecture-independent files in PREFIX
                          # [/usr/local]
  # --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
                          # [PREFIX]

# By default, `make install' will install all the files in
# `/usr/local/bin', `/usr/local/lib' etc.  You can specify
# an installation prefix other than `/usr/local' using `--prefix',
# for instance `--prefix=$HOME'.

# For better control, use the options below.

# Fine tuning of the installation directories:
  # --bindir=DIR            user executables [EPREFIX/bin]
  # --sbindir=DIR           system admin executables [EPREFIX/sbin]
  # --libexecdir=DIR        program executables [EPREFIX/libexec]
  # --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
  # --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
  # --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
  # --libdir=DIR            object code libraries [EPREFIX/lib]
  # --includedir=DIR        C header files [PREFIX/include]
  # --oldincludedir=DIR     C header files for non-gcc [/usr/include]
  # --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
  # --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
  # --infodir=DIR           info documentation [DATAROOTDIR/info]
  # --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
  # --mandir=DIR            man documentation [DATAROOTDIR/man]
  # --docdir=DIR            documentation root [DATAROOTDIR/doc/mpfr]
  # --htmldir=DIR           html documentation [DOCDIR]
  # --dvidir=DIR            dvi documentation [DOCDIR]
  # --pdfdir=DIR            pdf documentation [DOCDIR]
  # --psdir=DIR             ps documentation [DOCDIR]

# Program names:
  # --program-prefix=PREFIX            prepend PREFIX to installed program names
  # --program-suffix=SUFFIX            append SUFFIX to installed program names
  # --program-transform-name=PROGRAM   run sed PROGRAM on installed program names

# System types:
  # --build=BUILD     configure for building on BUILD [guessed]
  # --host=HOST       cross-compile to build programs to run on HOST [BUILD]

# Optional Features:
  # --disable-option-checking  ignore unrecognized --enable/--with options
  # --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
  # --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
  # --enable-silent-rules   less verbose build output (undo: "make V=1")
  # --disable-silent-rules  verbose build output (undo: "make V=0")
  # --disable-maintainer-mode
                          # disable make rules and dependencies not useful (and
                          # sometimes confusing) to the casual installer
  # --enable-gmp-internals  enable use of GMP undocumented functions [default=no]
  # --enable-assert         enable ASSERT checking [default=no]
  # --enable-logging        enable MPFR logging (the system must support it)
                          # [default=no]
  # --disable-thread-safe   explicitly disable TLS support
  # --enable-thread-safe    build MPFR as thread safe, i.e. with TLS support
                          # (the system must support it) [default=autodetect]
  # --enable-warnings       allow MPFR to output warnings to stderr [default=no]
  # --enable-tests-timeout=NUM
                          # [for developers] enable timeout for test programs
                          # (NUM seconds, <= 9999) [default=no]; if this is
                          # enabled, the environment variable $MPFR_TESTS_TIMEOUT
                          # overrides NUM (0: no timeout)
  # --enable-tune-for-coverage
                          # [for developers] tune MPFR for coverage tests
  # --enable-dependency-tracking
                          # do not reject slow dependency extractors
  # --disable-dependency-tracking
                          # speeds up one-time build
  # --disable-decimal-float explicitly disable decimal floats support
  # --enable-decimal-float  build conversion functions from/to decimal floats
                          # [default=autodetect]
  # --disable-float128      explicitly disable __float128 support
  # --enable-float128       build conversion functions from/to __float128
                          # [default=autodetect]
  # --enable-mini-gmp       build MPFR with mini-gmp (experimental) [default=no]
  # --enable-debug-prediction
                          # [for developers] enable debug of branch prediction
                          # (for x86 and x86-64 with GCC, static libs)
  # --enable-shared[=PKGS]  build shared libraries [default=yes]
  # --enable-static[=PKGS]  build static libraries [default=yes]
  # --enable-fast-install[=PKGS]
                          # optimize for fast installation [default=yes]
  # --disable-libtool-lock  avoid locking (might break parallel builds)

# Optional Packages:
  # --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
  # --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
  # --with-gmp-include=DIR  GMP include directory
  # --with-gmp-lib=DIR      GMP lib directory
  # --with-gmp=DIR          GMP install directory
  # --with-gmp-build=DIR    GMP build directory (please read INSTALL file)
  # --with-mulhigh-size=NUM internal threshold table for mulhigh
  # --with-pic[=PKGS]       try to use only PIC/non-PIC objects [default=use
                          # both]
  # --with-aix-soname=aix|svr4|both
                          # shared library versioning (aka "SONAME") variant to
                          # provide on AIX, [default=aix].
  # --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
  # --with-sysroot[=DIR]    Search for dependent libraries within DIR (or the
                          # compiler's sysroot if not specified).

# Some influential environment variables:
  # CC          C compiler command
  # CFLAGS      C compiler flags
  # LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
              # nonstandard directory <lib dir>
  # LIBS        libraries to pass to the linker, e.g. -l<library>
  # CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
              # you have headers in a nonstandard directory <include dir>
  # CPP         C preprocessor
  # LT_SYS_LIBRARY_PATH
              # User-defined run-time library search path.

# Use these variables to override the choices made by `configure' or to help
# it to find libraries and programs with nonstandard names/locations.

# Report bugs to the package provider.