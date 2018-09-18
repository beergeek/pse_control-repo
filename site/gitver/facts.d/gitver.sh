#!/bin/sh

GIT=`which git 2>/dev/null`
if [ $GIT = "" ]; then
  exit 0
fi

vers=`git --version|sed -e 's+^git version ++'`

echo "git_version=$vers"
exit 0
