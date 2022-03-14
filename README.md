# Accessing PASS

There are two approaches for direct access to PASS. Either going through the Shibboleth just like a member of the public or setting up an SSH tunnel directly to the backend. For the former, you will have to go through Shibboleth authentication. For the latter, you will need an account on the AWS servers.

In either case set an environment variable with the Elasticsearch index.
```
# Test PASS
export PASS_SCRIPTS_ES="https://test.pass.library.jhu.edu/es/"

# Production PASS
export PASS_SCRIPTS_ES="https://pass.library.jhu.edu/es/"

# Local PASS
export PASS_SCRIPTS_ES="http://localhost:9200/pass/_search"
```

## Shibboleth

Login either to PASS production, https://pass.jhu.edu/, or PASS test, https://test.pass.library.jhu.edu/. Bring up your developer tools and look for a request to a backend service like Elasticsearch on /es. Then find the Cookie header on the request and copy its value. Then set it as an environment variable.

```
export PASS_SCRIPTS_COOKIE='VALUE'
```

## SSH tunnel

You can setup SSH tunnels to access test fcrepo and elasticsearch on localhost ports 8080 and 9200 respectively. Note that the elasticsearch query endpoint will be http://localhost:9200/pass/es_search.

PASS test:
```
ssh -L localhost:8080:fcrepo-test.pass.local:8080 -L localhost:9200:elasticsearch-test.pass.cloud.library.jhu.edu:80 -i ~/.ssh/id_rsa USER@ops.pass.jhu.edu
```

PASS production:
```
ssh -L localhost:8080:fcrepo-prod.pass.local:8080 -L localhost:9200:elasticsearch-prod.pass.cloud.library.jhu.edu:80 -i ~/.ssh/id_rsa USER@ops.pass.jhu.edu
```

# Scripts

The scripts use the environment variables set above.

## Search


All the search scripts return up to 100 objects. You could modify them to page through results if needed.

Find objects whose fields has a given value. For example use `@id` to find objects with a given id. The pass data model documentation lists all the fields.
```
./find.sh 'FIELD' 'VALUE'
```

Find objects that contain the specified field.
```
./find_with_field.sh 'FIELD'
```

Find objects without the specified field.
```
./find_without_field.sh 'FIELD'
```

Find the Deposits and SubmissionEvents associated with a Submission.
```
./find_submission_graph SUBMISSION_ID
```

## Patching

The patch script will you update an object. Note that JSON Merge Patch is used.
For example, if the patch object sets a field to null, the field will be removed. To change a field value, the patch object just needs to contain that field with the new value.

You must be using a SSH tunnel for the script to work.

```
./patch.sh 'OBJECT_ID' PATCH_FILE
```

## Fedora

The get_raw script is a helper to get the raw RDF representation of a PASS object in Fedora.

```
./get_raw.sh 'OBJECT_ID'
```


