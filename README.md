# elastic6-marathon
Sample elastic6 deployment using marathon. Can also be deployed on http://dcos.io

# Caveats
Persistent Marathon services that use local volumes canot update resources such as: volume size, cpu usage, memory. See: https://dcos.io/docs/1.10/storage/persistent-volume/.

To upgrade resources, you can create a new service with same cluster settings but new resources under a new service id  *elastic6-data-2*.

This gives you a few options:

- Migrate the indices to the new nodes and shut down the old service: *elastic6-data*
- Leave old indices on smaller nodes and use templates to have new indexes created to new nodes only.
