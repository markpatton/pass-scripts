#! /bin/sh

FIELD="$1"
QUERY='{
  query: {
    bool: { must_not: {exists: {field: $FIELD}}}
  }
}'
SIZE="100"

json=$(jq -n --arg FIELD "$FIELD" "$QUERY")

echo "Elasticsearch index: $PASS_SCRIPTS_ES"
echo "Query: $json"
echo "Result:"

curl "${PASS_SCRIPTS_ES}?pretty&size=${SIZE}" \
  -H 'content-type: application/json; charset=utf-8' \
  -H "cookie: ${PASS_SCRIPTS_COOKIE}" \
  --data-raw "$json"
