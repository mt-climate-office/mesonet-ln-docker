#!/bin/bash

cd /opt/mesonet-ln-programs

git switch main
git pull --no-rebase
git show-branch ${1} &>/dev/null && git switch ${1} || git switch -C ${1}
git push --set-upstream origin ${1}
git pull --no-rebase

cora_cmd \
        --echo=on \
        --input="{
            connect localhost;
            get-program-file ${1}Photo --use-cache=true --file-name=${1}.txt --file-path=/opt/mesonet-ln-programs/;
            }"
    
#[ -s \\${1}.txt ] && mv \\${1}.txt ${1}.txt || rm -f \\${1}.txt
[ -s \\${1}.txt ] && mv \\${1}.txt USACE.CR1X || rm -f \\${1}.txt
    
git add .
git commit -m "updated ${1} program backup"
git push
git switch main
