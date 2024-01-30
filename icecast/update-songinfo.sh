#!/bin/sh

echo "Setting stream name to $2"

curl -G -u "admin:$1" "https://icecast-test.purefm.xyz/admin/metadata" \
	--data-urlencode "mount=/stream" --data-urlencode "mode=updinfo" --data-urlencode "song=$2"
curl -G -u "admin:$1" "https://icecast-test.purefm.xyz/admin/metadata" \
	--data-urlencode "mount=/backup" --data-urlencode "mode=updinfo" --data-urlencode "song=$2"
