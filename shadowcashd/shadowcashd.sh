#!/bin/bash

cmd=$1
shift

# expand environment in bitcoind.conf template
#mv shadowcoin.conf shadowcoin-template.conf
#perl -pe 's/\$(\w+)/$ENV{$1}/g' shadowcoin-template.conf > shadowcoin.conf
#SHADOWCASHD_PREFIX="shadowcashd -conf=/shadowcashd/.shadowcoin/shadowcoin.conf -datadir=/shadowcashd/.shadowcoin/data"

init() {
   # This shouldn't be in the Dockerfile or containers built from the same image
   # will have the same credentials.
   if [ ! -e "$HOME/.shadowcoin/shadowcoin.conf" ]; then
      mkdir -p $HOME/.shadowcoin
      cp /shadowcashd/shadowcoin.conf /shadowcashd/.shadowcoin/shadowcoin.conf
      shadowcashd 2>&1 | grep "^rpc" > $HOME/.shadowcoin/init.log
   fi
}

case $cmd in
   shell)
      sh -c "$*"
      exit $?
      ;;
   login)
      bash -l
      exit $?
      ;;
   init)
      init
      exit 0
      ;;
   shadowcashd)
      shadowcashd "$@"
      exit $?
      ;;
   log)
      tail -f $HOME/.shadowcoin/debug.log
      ;;
   getconfig)
      cat $HOME/.shadowcoin/shadowcoin.conf
      ;;
   rpc)
      set -x
      exec shadowcashd -rpcconnect=$SHADOWCASHD_RPC_IP -rpcport=$SHADOWCASHD_RPC_PORT ${*:2} "$@"
      exit $?
      ;;
   *)
      echo "shadowcashd.sh, unknown cmd: $cmd"
      exit 1
esac