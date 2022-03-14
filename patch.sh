#! /bin/sh

ID="$1"
FILE="$2"
curl "$ID" -X PATCH -u fedoraAdmin:moo\
  -H 'content-type: application/merge-patch+json; charset=utf-8' \
  -H "cookie: ${PASS_SCRIPTS_COOKIE}" \
  --data-binary "@${FILE}"
