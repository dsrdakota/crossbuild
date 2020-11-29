#!/bin/bash -i
[[ -z "$TOPSHDIR" ]] && export TOPSHDIR=`dirname $(realpath $0)`
[[ "$-" != *i* ]] && return
. $TOPSHDIR/env.sh
function log_func() {
	[[ -z "$@" ]] && echo -e "\e[1m\e[38;5;196musage: log <message>\e[0;0m" && return 0
	echo -e "\e[1m\e[48;5;154m\e[38;5;196m$@\e[0;0m"
}

alias log='log_func'
[[ ! -v BUILD_STATUS ]] && export BUILD_STATUS=-1

# set -e
set -E
set -o pipefail
function build_errored() {
	export BUILD_STATUS=$?
	# let argc=$#
	# argv=$@
	# a=$_
	# STAT=$BUILD_STATUS
	[[ -n "$BASH_COMMAND" ]] && LAST_COMMAND=`echo $BASH_COMMAND|cut -d\  -f1` || LAST_COMMAND="(null)"
	[[ -n "$LAST_COMMAND" ]] && log "Process $LAST_COMMAND: $BUILD_STATUS" 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	log "Error: Build returned errors." 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	case $LAST_COMMAND in
		autogen.sh|configure|make|isl.sh|osl.sh|gcc.sh|binutils.sh|crossbuild.sh|mpc.sh|mpfr.sh|gmp.sh|cloog.sh)
			[[ -n "$LAST_COMMAND" ]] && log "Process $LAST_COMMAND: $BUILD_STATUS" 2>&1 | tee -a $TOPSHDIR/crossbuild.log;
			exit $BUILD_STATUS;
			;;
		*)
			# [[ -n "$LAST_COMMAND" ]] && log "Process $LAST_COMMAND: $BUILD_STATUS"
			[[ $BUILD_STATUS -gt 1 ]] && return $BUILD_STATUS;;
	esac
	return $BUILD_STATUS
}
function build_terminated() {
	export BUILD_STATUS=$?
	[[ -n "$BASH_COMMAND" ]] && LAST_COMMAND=`echo $BASH_COMMAND|cut -d\  -f1` || LAST_COMMAND="(null)"
	[[ -n "$LAST_COMMAND" ]] && log "Process $LAST_COMMAND: $BUILD_STATUS" 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	log "Error: Build terminated." 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	return $BUILD_STATUS
}
function build_aborted() {
	export BUILD_STATUS=$?
	[[ -n "$BASH_COMMAND" ]] && LAST_COMMAND=`echo $BASH_COMMAND|cut -d\  -f1` || LAST_COMMAND="(null)"
	[[ -n "$LAST_COMMAND" ]] && log "Process $LAST_COMMAND: $BUILD_STATUS" 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	return $BUILD_STATUS
}
function build_quit() {
	export BUILD_STATUS=$?
	[[ -n "$BASH_COMMAND" ]] && LAST_COMMAND=`echo $BASH_COMMAND|cut -d\  -f1` || LAST_COMMAND="(null)"
	[[ -n "$LAST_COMMAND" ]] && log "Process $LAST_COMMAND: $BUILD_STATUS" 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	log "Error: Build wanted to give up and quit." 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	return $BUILD_STATUS
}
function build_interrupted() {
	export BUILD_STATUS=$?
	[[ -n "$BASH_COMMAND" ]] && LAST_COMMAND=`echo $BASH_COMMAND|cut -d\  -f1` || LAST_COMMAND="(null)"
	[[ -n "$LAST_COMMAND" ]] && log "Process $LAST_COMMAND: $BUILD_STATUS" 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	log "Error: Build interrupted." 2>&1 | tee -a $TOPSHDIR/crossbuild.log
	return $BUILD_STATUS
}
function build_proc_exit() {
	[[ -n "$BASH_COMMAND" ]] && LAST_COMMAND=`echo $BASH_COMMAND|cut -d\  -f1` || LAST_COMMAND="(null)"
	[[ -n "$LAST_COMMAND" ]] && log "Process $LAST_COMMAND: $BUILD_STATUS" 2>&1 | tee -a $TOPSHDIR/crossbuild.log ||
		log "LOG: Last process exited with status $?." 2>&1 | tee -a $TOPSHDIR/crossbuild.log
}
trap build_proc_exit EXIT
trap build_errored ERR
trap build_terminated SIGTERM
trap build_quit SIGQUIT
trap build_aborted SIGABRT
trap build_interrupted SIGINT
# trap build_new_proc 


function get_gmp_snapshot() {
#	GMP6_URL="https://gmplib.org/download/snapshot/gmp-6.*.*-SNAPSHOT.tar.lz"
	GMP_URL="https://gmplib.org/download/snapshot/gmp-6.*.*-SNAPSHOT.tar.lz"
	SNAPSHOT=
	[[ -n "$@" ]] && while "$1"; do
		case "$1" in
			-d|-D|--date)
				date -d "$2" 2>&1 1>/dev/null
				if [[ $? -eq 0 ]]; then
					SNAPSHOT=$2
				fi
				shift 2
				;;
			-d=*|-D=*|--date=*)
				date -d `echo $1|cut -d= -f2` 2>&1 1>/dev/null
				if [[ $? -eq 0 ]]; then
					SNAPSHOT=`echo $1|cut -d= -f2`
				fi
				shift
				;;
		esac
	done
	if [[ ! -v SNAPSHOT ]]; then
		SNAPSHOT=$(date +%Y%m%d)
	fi
	GMP_URL=`echo $GMP_URL|sed -e 's/SNAPSHOT/$SNAPSHOT/'`
	wget --spider $GMP_URL
}

function decompress_gmp_snapshot {
	[[ ! -f "$1" ]] && echo "file not found or incorrect usage. usage: decompress_gmp_snapshot file" && return 1
	tar -I zstd -xvf $1
}

function init_submodules {
	git submodule update --init --recursive
}

function update_modules {
	
}