#!/bin/sh
if [ $# -lt 2 ]; then
  echo "$0 tag1 tag2"
  echo "Use "git tag -l" to see available tags"
  exit 1
fi
PWD=`pwd`
FNP=$PWD/output_patch
FNN=$PWD/output_numstat
cd ~/dev/go/src/k8s.io/kubernetes/
git config merge.renameLimit 10000
git config diff.renameLimit 10000
# -m --> map unknowns to 'DomainName *' , -u map unknowns to '(Unknown)'
git log -p -M $1..$2 | ~/dev/cncf/gitdm/cncfdm.py -b ~/dev/cncf/gitdm/ -t -z -d -D -U -m -h $FNP.html -o $FNP.txt -x $FNP.csv
git log --numstat -M $1..$2 | ~/dev/cncf/gitdm/cncfdm.py -n -b ~/dev/cncf/gitdm/ -t -z -d -D -U -m -h $FNN.html -o $FNN.txt -x $FNN.csv > $FNN.out
git config --unset diff.renameLimit
git config --unset merge.renameLimit
ls -l $FNP* $FNN*
cd $PWD