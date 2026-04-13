FROM ghcr.io/zynthasius31/brsp-spring:0.9.23
USER root:root
COPY initSpring.sh /

ENTRYPOINT ["/bin/sh", "/initSpring.sh"]
