# elastic6-marathon
~~Proof of concept~~ elastic6 deployment using marathon. Can also be deployed on http://dcos.io.

This deploys a production style topology of Elasticsearch with 3 master nodes, 3 data nodes, 1 ingest node and 3 coordinator nodes.

This deployment has been is use in production for over 3 months now.

# Deployment
- Run marathon.json, this deploys 3 master nodes.
- Run marathon-data.json, this deploys 3 data nodes.
- Run marathon-ingest.json, this deploys 1 ingest nodes.
- Run marathon-corrdinator.json, this deploys 3 coordinator nodes.

Make sure to set the required ulimits/memory settings on the host machines as described here: https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html

You can modify the marathon files as desired.

Ensure you change **ELASTIC_PASSWORD**.

# Service Discovery
- Master nodes available at: **es6.marathon.l4lb.thisdcos.directory**
- Ingest nodes available at: **ingest6.marathon.l4lb.thisdcos.directory**
- Data nodes available at: **data6.marathon.l4lb.thisdcos.directory**
- Coordinator nodes available at: **coordinator6.marathon.l4lb.thisdcos.directory**

*discovery.zen.ping.unicast.hosts* is pointing to the master nodes: **es6.marathon.l4lb.thisdcos.directory**

You can also expose the nodes to your external network using **HAPROXY_GROUP** and **HAPROXY_0_VHOST**. See coordinator and data nodes as example.



# Caveats
Persistent Marathon services that use local volumes cannot update resources such as: volume size, cpu usage, memory. See: https://dcos.io/docs/1.10/storage/persistent-volume/.

To upgrade resources, you can create a new service with same cluster settings but new with resources under a different service id  **elastic6-data-2**.

This gives you a couple options:

- Migrate the indices to the new nodes and shut down the old service: **elastic6-data**
- Leave old indices on smaller nodes and use templates to have new indexes created to new nodes only.
