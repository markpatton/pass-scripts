#! /bin/sh

ID="$1"
curl "$ID" -X DELETE -u "${PASS_SCRIPTS_FCREPO_CREDENTIALS}" -H "cookie: ${PASS_SCRIPTS_COOKIE}" 
