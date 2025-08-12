FROM alpine:latest
LABEL authors="i.fominykh"

COPY health-service /usr/bin/health-service/
RUN chmod +x /usr/bin/health-service/health-service

ENTRYPOINT ["/usr/bin/health-service/health-service"]