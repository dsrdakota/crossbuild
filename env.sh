#!/bin/bash -i
[[ "$-" != *i* ]] && return
if [[ ! -v "CROSS_TOOLCHAIN_ENV_DEFINED" ]]; then
	if [[ -z "$TRIPLET" ]]; then
		export TRIPLET=$(`which cc` -dumpmachine)
	else
		[[ $# -ge 1 ]] && [[ -n "$1" ]] && [[ "x$($1-gcc -dumpmachine)" != "x" ]] && export TRIPLET=$1 ||
			export TRIPLET=$(`which cc` -dumpmachine)
	fi
		
	[[ -n "$HOST_TRIPLET" ]] && HOST_TRIPLET=$HOST_TRIPLET || [[ -n "$TRIPLET" ]] && HOST_TRIPLET=$TRIPLET || HOST_TRIPLET=x86_64-w64-mingw32
	CC="$HOST_TRIPLET-gcc"
	CFLAGS="-std=gnu11 "
	CXX="$HOST_TRIPLET-g++"
	CXXFLAGS="-std=gnu++1z"
	LDFLAGS="-pg -Wl,--add-stdcall-alias,--enable-stdcall-fixup,--compat-implib,--nxcompat -static"
	LD=""
	NM="$HOST_TRIPLET-nm"
	CPP="$HOST_TRIPLET-cpp -x c -std=gnu11"
	CXXCPP="$HOST_TRIPLET-cpp -std=gnu++1z -x c++"
	CC_FOR_BUILD="$HOST_TRIPLET-gcc"
	CPP_FOR_BUILD="$HOST_TRIPLET-cpp"
	PKG_CONFIG="$HOST_TRIPLET-pkg-config -static"
	ABI="64"
	export HOST_TRIPLET CC CXX CXXCPP CPP LD NM CC_FOR_BUILD CPP_FOR_BUILD ABI CFLAGS CXXFLAGS LDFLAGS


	export TARGET=x86_64-elf
	
	export CROSS_TOOLCHAIN_ENV_DEFINED=1
fi
