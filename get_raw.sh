#! /bin/sh

ID="$1"

curl "${ID}" -H "cookie: ${PASS_SCRIPTS_COOKIE}"
