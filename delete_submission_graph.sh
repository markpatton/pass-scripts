#! /bin/sh

ID="$1"
SIZE="100"
QUERY='{
  query: {
    bool: {
      should: [{term: {submission: $ID}}, {term: {"@id": $ID}}]
    }
  }
}'

json=$(jq -n --arg ID "$ID" "$QUERY")

echo "Elasticsearch index: $PASS_SCRIPTS_ES"
echo "Query: $json"

result=$(curl "${PASS_SCRIPTS_ES}?pretty&size=${SIZE}" \
  -H 'content-type: application/json; charset=utf-8' \
  -H "cookie: ${PASS_SCRIPTS_COOKIE}" \
  --data-raw "$json")

echo "Submission graph: $result"

echo "fcrepo must be available as localhost:8080"

for i in $(echo "$result" | jq -r '.hits.hits[]._source["@id"]'); do
    i="http://localhost:8080/fcrepo${i#*fcrepo}"
    echo "Deleting $i"
    ./delete.sh $i
    sleep 1
    
done

# Also get file...


