# elastic6-marathon
Proof of concept elastic6 deployment using marathon. Can also be deployed on http://dcos.io.

This deploys a production style topology of Elasticsearch with 3 master nodes, 3 data nodes, 1 ingest node.

# Deployment
- Run marathon.json, this deploys 3 master nodes.
- Run marathon-data.json, this deploys 3 data nodes.
- Run marathon-ingest.json, this deploys 1 ingest nodes.

Make sure to set the required ulimits/memory settings on the host machines as described here: https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html

You can modify the marathon files as desired.

# Caveats
Persistent Marathon services that use local volumes canot update resources such as: volume size, cpu usage, memory. See: https://dcos.io/docs/1.10/storage/persistent-volume/.

To upgrade resources, you can create a new service with same cluster settings but new resources under a new service id  *elastic6-data-2*.

This gives you a few options:

- Migrate the indices to the new nodes and shut down the old service: *elastic6-data*
- Leave old indices on smaller nodes and use templates to have new indexes created to new nodes only.
