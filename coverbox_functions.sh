#!/bin/bash

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
 
function parse_git_root () {
  pushd . > /dev/null
  until [ -d ".git" ] || [ "`pwd`" = "/" ] ; do cd .. ; done
  if [ "`pwd`" != "/" ]
  then
    pwd | sed -e 's/.*\/\([^\/]*\)/(\1)/'
  fi
  popd > /dev/null
}
 
function add_remote () {
  branchname=$1
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
