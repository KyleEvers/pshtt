#!/bin/bash

if [ "$USER_ID" ]; then
	uid="$USER_ID"
else
	cat >&2 <<-'EOINFO'
	INFO: No uid as been specified, 1000 will be used by
	default.
	Use "-e USER_ID=1042" to set it in "docker run".
	****************************************************
	EOINFO

	uid=1000
fi

if [ "$GROUP_ID" ]; then
	gid="$GROUP_ID"
else
	cat >&2 <<-'EOINFO'
	INFO: No gid as been specified, 1000 will be used by
	default.
	Use "-e GROUP_ID=1042" to set it in "docker run".
	****************************************************
	EOINFO

	gid=1000
fi

./pshtt_cli $@

chown -R "${uid}:${gid}" /usr/src/app/
