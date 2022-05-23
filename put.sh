#! /bin/sh

ID="$1"
FILE="$2"
curl -v "$ID" -X PUT -u "${PASS_SCRIPTS_FCREPO_CREDENTIALS}"\
  -H 'content-type: application/ld+json; charset=utf-8' \
  -H "cookie: ${PASS_SCRIPTS_COOKIE}" \
  --data-binary "@${FILE}"
