FROM alpine:latest
LABEL authors="i.fominykh"

COPY bin/dosa /usr/bin/dosa/
RUN chmod +x /usr/bin/dosa/dosa

ENTRYPOINT ["/usr/bin/dosa/dosa"]