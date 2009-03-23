#!/bin/bash
source ~/.my_git/coverbox_functions.sh

case "$1" in
  "remote_branch")
  case "$2" in
    "add")
    add_branch $3
    ;;

    "del")
    del_branch $3
    ;;

    *)
    echo "usage: $0 $1 [add|del] <branchname>"
    echo "Adds or removes configuration to track a local branch to the remote with the same name"
  esac
  ;;

  "remote_track")
  case "$2" in
    "add")
    add_track $3
    ;;

    "del")
    del_track $3
    ;;

    *)
    echo "usage: $0 $1 [add|del] <branchname>"
    echo "Adds a remote branch to you tracking branches and fetches it."
  esac
  ;;

  "local_change")
  case "$2" in
    "publish")
    publish $3
    ;;

    "receive")
    receive $3
    ;;

    "rid")
    rid $3
    ;;

    *)
    echo "usage: $0 $1 [add|del] <branchname>"
    echo "Adds a remote branch to you tracking branches and fetches it."
    ;;
  esac
  ;;
esac