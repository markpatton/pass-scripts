#! /bin/sh

FIELD="$1"
VALUE="$2"
QUERY='{
  query: {
    term: {($FIELD): $VALUE}
  }
}'
SIZE="100"

json=$(jq -n --arg FIELD "$FIELD" --arg VALUE "$VALUE" "$QUERY")

echo "Elasticsearch index: $PASS_SCRIPTS_ES"
echo "Query: $json"
echo "Result:"
curl "${PASS_SCRIPTS_ES}?pretty&size=${SIZE}" \
  -H 'content-type: application/json; charset=utf-8' \
  -H "cookie: ${PASS_SCRIPTS_COOKIE}" \
  --data-raw "$json"
