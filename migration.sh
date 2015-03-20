#!/bin/sh

# Set variable
cloneUrl="git@github.com:eva-xuyen/migration.git"
sortRepoName="migration"
branchFile="branch.txt"

# Get list current submodules
subModuleList=$(grep path .gitmodules | sed 's/.*= //')

# Create submodule
while read branchname;
do
  submoduleDir=$sortRepoName"_"$branchname
  if echo $subModuleList | grep -qv $branchname;
  then
    git submodule add -b $branchname $cloneUrl $submoduleDir
    git config -f .gitmodules submodule.$submoduleDir.branch $branchname
  fi
done < $branchFile

# To use submodule
git submodule update --init