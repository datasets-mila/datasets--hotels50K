#!/bin/bash

# This script is meant to be used with the command 'datalad run'

# cs.slu.edu doesn't have valid certificates preventing git-annex from
# authorizing the download
wget --no-check-certificate https://cs.slu.edu/~stylianou/images/hotels-50k/test.tar.lz4

for file_url in "http://cs.slu.edu/~stylianou/images/hotels-50k/test.tar.lz4 test.tar.lz4"
do
	echo ${file_url} | git-annex addurl -c annex.largefiles=anything --raw --batch --with-files
done

md5sum test.tar.lz4 > md5sums
