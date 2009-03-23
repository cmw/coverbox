#!/bin/bash

function add_remote () {
  branchname=$0
  git config branch.$branchname.remote origin
  git config branch.$branchname.merge refs/heads/$branchname
}

function del_remote () {
  branchname=$1
  git config --unset branch.$branchname.remote
  git config --unset branch.$branchname.merge
}

function add_track () {
  branchname=$1
  git config --add remote.origin.fetch +refs/heads/$branchname:refs/remotes/origin/$branchname
  git fetch origin $branchname:refs/remotes/origin/$branchname
}

function del_track () {
  branchname=$1
  git config --unset-all remote.origin.fetch refs/heads/$branchname:refs/remotes/origin/$branchname
  git branch -r -d origin/$branchname
}

function get_ref () {
  branchname=$1
  git ls-remote origin $branchname | sed -e "s/\\([0-f]*\\).*/\\1/"
}

function pull_project () {
  branchname=$1
  git fetch origin $branchname
  git checkout -b $branchname `get_ref $branchname`
}

function publish () {
  branchname=$1
  git push origin $branchname
  add_remote $branchname
  add_track $branchname  
}

function receive () {
  branchname=$1
  pull_project $branchname
  add_remote $branchname
  add_track $branchname
}

function rid () {
  branchname=$1
  git branch -d $branchname
  del_remote $branchname
  del_track $branchname
}

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