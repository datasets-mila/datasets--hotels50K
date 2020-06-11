#!/bin/bash

pip install -r scripts/requirements_extract.txt
ERR=$?
if [ $ERR -ne 0 ]; then
   echo "Failed to install requirements: pip install: $ERR"
   exit $ERR
fi

mkdir -p extract/
mkdir -p images/

jug status -- scripts/extract.py test.tar.lz4 --output extract/
jug execute -- scripts/extract.py test.tar.lz4 --output extract/ 1>> extract.out 2>> extract.err
jug status -- scripts/extract.py extract/ --output images/ --delete
jug execute -- scripts/extract.py extract/ --output images/ --delete 1>> extract.out 2>> extract.err

rm files_count.stats
for dir in images/*/*
do
	echo $(find $dir -type f | wc -l; echo $dir) >> files_count.stats
done

du -s images/*/* > disk_usage.stats
