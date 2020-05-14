#!/bin/bash

# this script is meant to be used with 'datalad run'

pip install -r scripts/requirements_download_train.txt
ERR=$?
if [ $ERR -ne 0 ]; then
   echo "Failed to install requirements: pip install: $ERR"
   exit $ERR
fi

python scripts/download_train.py 1>> download_train.out 2>> download_train.err

rm files_count.stats
for dir in images/*/*
do
	echo $(find $dir -type f | wc -l; echo $dir) >> files_count.stats
done

du -s images/*/* > disk_usage.stats
