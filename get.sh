#! /bin/sh

ID="$1"

curl "${ID}" -u "${PASS_SCRIPTS_FCREPO_CREDENTIALS}" -H "cookie: ${PASS_SCRIPTS_COOKIE}"  -H 'Accept: application/ld+json' 
