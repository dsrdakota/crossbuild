#!/bin/bash -i
[[ -z "$TOPSHDIR" ]] && export TOPSHDIR=`dirname $(realpath $0)`
. $TOPSHDIR/funcs.sh
[[ "$PWD" != "$TOPSHDIR" ]] && cd $TOPSHDIR
[[ ! -d gmp ]] && hg clone https://gmplib.org/repo/gmp && cd gmp || cd gmp && hg update -C
log "Cleaning stale object files and distribution files for package 'gmp' ..."
make clean distclean
log "Generating configuration files for 'gmp' ..."
OLDLDFLAGS="$LDFLAGS"
LDFLAGS="-pg -Wl,--add-stdcall-alias,--enable-stdcall-fixup,--compat-implib,--nxcompat"
export LDFLAGS
./.bootstrap
log "Configuring for package 'gmp' ..."
./configure --prefix=$CROSS_PREFIX --build=$HOST_TRIPLET --enable-cxx=yes --enable-assembly=yes --with-readline --enable-minithres=yes --enable-profiling=gprof --enable-fft=yes --enable-alloca=reentrant --enable-nails=no --with-sysroot=$CROSS_PREFIX --with-gnu-ld=yes --enable-static=yes --enable-shared=no
[[ $? -eq 0 ]] && log "Building package 'gmp' ..." && make -j4 && [[ $? -eq 0 ]] && log "Installing package 'gmp' to $CROSS_PREFIX ..." && make install && log "Running tests for package 'gmp' ..." && make -j8 check
LDFLAGS="$OLDLDFLAGS"
export LDFLAGS
# `configure' configures GNU MP 6.1.99 to adapt to many kinds of systems.

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
  # --docdir=DIR            documentation root [DATAROOTDIR/doc/gmp]
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
  # --enable-maintainer-mode
                          # enable make rules and dependencies not useful (and
                          # sometimes confusing) to the casual installer
  # --enable-assert         enable ASSERT checking [default=no]
  # --enable-alloca         how to get temp memory [default=reentrant]
  # --enable-cxx            enable C++ support [default=no]
  # --enable-assembly       enable the use of assembly loops [default=yes]
  # --enable-fft            enable FFTs for multiplication [default=yes]
  # --enable-old-fft-full   enable old mpn_mul_fft_full for multiplication
                          # [default=no]
  # --enable-nails          use nails on limbs [default=no]
  # --enable-profiling      build with profiler support [default=no]
  # --enable-fat            build fat libraries on systems that support it
                          # [default=no]
  # --enable-minithres      choose minimal thresholds for testing [default=no]
  # --enable-fake-cpuid     enable GMP_CPU_TYPE faking cpuid [default=no]
  # --enable-shared[=PKGS]  build shared libraries [default=yes]
  # --enable-static[=PKGS]  build static libraries [default=yes]
  # --enable-fast-install[=PKGS]
                          # optimize for fast installation [default=yes]
  # --disable-libtool-lock  avoid locking (might break parallel builds)

# Optional Packages:
  # --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
  # --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
  # --with-readline         readline support in demo programs [default=detect]
  # --with-pic[=PKGS]       try to use only PIC/non-PIC objects [default=use
                          # both]
  # --with-aix-soname=aix|svr4|both
                          # shared library versioning (aka "SONAME") variant to
                          # provide on AIX, [default=aix].
  # --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
  # --with-sysroot[=DIR]    Search for dependent libraries within DIR (or the
                          # compiler's sysroot if not specified).

# Some influential environment variables:
  # ABI         desired ABI (for processors supporting more than one ABI)
  # CC          C compiler command
  # CFLAGS      C compiler flags
  # LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
              # nonstandard directory <lib dir>
  # LIBS        libraries to pass to the linker, e.g. -l<library>
  # CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
              # you have headers in a nonstandard directory <include dir>
  # CPP         C preprocessor
  # CC_FOR_BUILD
              # build system C compiler
  # CPP_FOR_BUILD
              # build system C preprocessor
  # CXX         C++ compiler command
  # CXXFLAGS    C++ compiler flags
  # CXXCPP      C++ preprocessor
  # LT_SYS_LIBRARY_PATH
              # User-defined run-time library search path.
  # M4          m4 macro processor
  # YACC        The `Yet Another Compiler Compiler' implementation to use.
              # Defaults to the first program found out of: `bison -y', `byacc',
              # `yacc'.
  # YFLAGS      The list of arguments that will be passed by default to $YACC.
              # This script will default YFLAGS to the empty string to avoid a
              # default value of `-d' given by some make applications.

# Use these variables to override the choices made by `configure' or to help
# it to find libraries and programs with nonstandard names/locations.

# Report bugs to <gmp-bugs@gmplib.org, see https://gmplib.org/manual/Reporting-Bugs.html>.
# GNU MP home page: <http://www.gnu.org/software/gmp/>.
# General help using GNU software: <http://www.gnu.org/gethelp/>.