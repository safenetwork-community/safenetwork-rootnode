# Build SafeNetwork docker container
FROM docker.io/library/alpine:3.14
LABEL version="1.2"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2022-01-05"

# Update and install dependencies
RUN apk update && apk add \
  bash \
  curl \
  jq

RUN addgroup -g 1000 admin
RUN adduser -s /bin/bash --ingroup admin --uid 1000 --disabled-password admin
USER admin
WORKDIR /home/admin

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/sn_install.sh -o /tmp/sn_install.sh
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/sn_install_latest.sh -o /tmp/sn_install_latest.sh
RUN bash /tmp/sn_install_latest.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.safe:/home/admin/.safe/node

# Default env values
ENV CON_IP=10.0.2.100
ENV CON_PORT=12000
ENV PUB_IP=10.0.2.100
ENV PUB_PORT=12000

# Expose PORT of the node
EXPOSE $CON_PORT

# Assign volume
VOLUME /home/admin/.safe/cli

# Launch safe root node
ENTRYPOINT sn_node -vv \
  --idle-timeout-msec 5500 \
  --keep-alive-interval-msec 4000 \
  --skip-auto-port-forwarding \
  --local-addr ${CON_IP}:${PUB_PORT} \
  --public-addr ${PUB_IP}:${PUB_PORT} \
  --first
