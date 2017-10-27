#!/usr/bin/env bash

url=http://para:8080/v1/_setup
volume_dir=/var/lib/para
saved_result=$volume_dir/_setup

if [[ -s $ACCESS_KEY_PATH && -s $SECRET_KEY_PATH ]]
then
	# do nothing
	exit 0
fi

if ! [[ -s $saved_result ]]
then
	curl -s -f http://para:8080/v1/_setup >$saved_result
fi
if ! grep -q secretKey $saved_result
then
	rm -f $saved_result
	exit 1
fi
sed -n '/accessKey/s/.*: "\(.*\)".*/\1/p' $saved_result >"$ACCESS_KEY_PATH" || exit 1
sed -n '/secretKey/s/.*: "\(.*\)".*/\1/p' $saved_result >"$SECRET_KEY_PATH" || exit 1
rm -f $saved_result
