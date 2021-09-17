FROM adoptopenjdk:11-jre-hotspot
ARG CBESCONN_VER=4.3.1-SNAPSHOT
ENV CBESCONN_VER=$CBESCONN_VER

# Add metadata to the image to describe which port the container is listening on at runtime.
# Web port
EXPOSE 3145
# Prometheus port
EXPOSE 9000

LABEL Description="Couchbase Elasticsearch Connector" Vendor="Couchbase, Inc." Version="${CBESCONN_VER}"

# Copy the file from your host to your current location.
RUN mkdir -p /opt/cbes/couchbase-elasticsearch-connector && mkdir -p /opt/etc/cbes

# TODO: use ADD to just explode the distribution in one go.
COPY build/distributions/couchbase-elasticsearch-connector-${CBESCONN_VER} /opt/cbes/couchbase-elasticsearch-connector
COPY build/distributions/couchbase-elasticsearch-connector-${CBESCONN_VER}/config/example-connector.toml /opt/cbes/couchbase-elasticsearch-connector/config/default-connector.toml

# TODO: script should be built locally with substitution and then copied in with var in it; no var substitution for CMD allowd to ensure immutability
CMD ["/opt/cbes/couchbase-elasticsearch-connector/bin/cbes"]
