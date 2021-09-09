FROM adoptopenjdk:11-jre-hotspot
ENV CBESCONN_VER=4.3.1-SNAPSHOT
#Version: SEE BELOW too for now
LABEL Description="Couchbase Elasticsearch Connector" Vendor="Couchbase, Inc." Version="${CBESCONN_VER}"

# Set the working directory.

# Copy the file from your host to your current location.
RUN mkdir -p /opt/cbes/couchbase-elasticsearch-connector-${CBESCONN_VER}
#RUN mkdir /opt/etc
RUN mkdir -p /opt/etc/cbes
#COPY config.toml /opt/app

# TODO: should just get the exploded distribution and copy that over.  Need gradle build target.
COPY build/distributions/couchbase-elasticsearch-connector-${CBESCONN_VER} /opt/cbes/couchbase-elasticsearch-connector-${CBESCONN_VER}
COPY build/distributions/couchbase-elasticsearch-connector-${CBESCONN_VER}/config/example-connector.toml /opt/cbes/couchbase-elasticsearch-connector-4.3.1-SNAPSHOT/config/default-connector.toml
# TODO: script should be built locally with substitution and then copied in with var in it; no var substitution for CMD allowd to ensure immutability
CMD ["/opt/cbes/couchbase-elasticsearch-connector-4.3.1-SNAPSHOT/bin/cbes"]

# Add metadata to the image to describe which port the container is listening on at runtime.
# Web port
EXPOSE 3145
# Prometheus port
EXPOSE 9000
