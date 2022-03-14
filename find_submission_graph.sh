#! /bin/sh

ID="$1"
SIZE="100"
QUERY='{
  query: {
    bool: {
      should: [{term: {submission: $ID}}, {term: {@id: $ID}}]
    }
  }
}'

json=$(jq -n --arg ID "$ID" "$QUERY")

echo "Elasticsearch index: $PASS_SCRIPTS_ES"
echo "Query: $json"
echo "Result:"

curl "${PASS_SCRIPTS_ES}?pretty&size=${SIZE}" \
  -H 'content-type: application/json; charset=utf-8' \
  -H "cookie: ${PASS_SCRIPTS_COOKIE}" \
  --data-raw "$json"
