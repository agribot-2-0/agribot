#!/usr/bin/env bash

export AGRIBOT_HOME=$HOME

cd $AGRIBOT_HOME/agribot/workspace/base_ws/src

git checkout master
git stash
git submodule update
git submodule foreach 'git stash'
git submodule foreach 'git checkout master'
git submodule foreach 'git pull'
git branch -D feature/freeze
git checkout -b feature/freeze
git add agribot_*
git commit -m "`date +'%d.%m.%Y'` agribot_base"
git push origin feature/freeze
git checkout master
git branch -D feature/freeze

cd $AGRIBOT_HOME/agribot/workspace/hal_ws/src

git checkout master
git stash
git submodule update
git submodule foreach 'git stash'
git submodule foreach 'git checkout master'
git submodule foreach 'git pull'
git branch -D feature/freeze
git checkout -b feature/freeze
git add hal_*
git commit -m "`date +'%d.%m.%Y'` agribot_hal"
git push origin feature/freeze
git checkout master
git branch -D feature/freeze
