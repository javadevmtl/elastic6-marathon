FROM docker.elastic.co/elasticsearch/elasticsearch-platinum:6.2.2

USER root

# Example how to add plugin for s3 backups.
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin list

RUN echo "xxxxxx" | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.access_key
RUN echo "xxxxxx" | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.secret_key
