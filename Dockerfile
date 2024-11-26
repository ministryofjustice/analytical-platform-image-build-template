# checkov:skip=CKV_DOCKER_2:Healthcheck instructions have not been added to container images
# This image is an example base image for this template and can be replaced to fit user needs
FROM public.ecr.aws/ubuntu/ubuntu@sha256:0489ba01d3b98bbbff4561d473f50814970cd429fa335b61a0f0a21fd5fa32c1

LABEL org.opencontainers.image.vendor="Ministry of Justice" \
      org.opencontainers.image.authors="Analytical Platform (analytical-platform@digital.justice.gov.uk)"\
      org.opencontainers.image.title="{image title}" \
      org.opencontainers.image.description="{decription}" \
      org.opencontainers.image.url="{your repo url}"

ENV CONTAINER_USER="analyticalplatform" \
    CONTAINER_UID="1001" \
    CONTAINER_GROUP="analyticalplatform" \
    CONTAINER_GID="1001" \
    DEBIAN_FRONTEND="noninteractive"

SHELL ["/bin/bash", "-e", "-u", "-o", "pipefail", "-c"]

# User
RUN <<EOF
groupadd \
  --gid ${CONTAINER_GID} \
  ${CONTAINER_GROUP}

useradd \
  --uid ${CONTAINER_UID} \
  --gid ${CONTAINER_GROUP} \
  --create-home \
  --shell /bin/bash \
  ${CONTAINER_USER}
EOF

# Base
RUN <<EOF
apt-get update --yes

apt-get install --yes \
  "curl=8.9.1-2ubuntu2"

apt-get clean --yes

rm --force --recursive /var/lib/apt/lists/*
EOF

USER ${CONTAINER_USER}

WORKDIR /home/${CONTAINER_USER}

