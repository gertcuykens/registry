FROM debian AS root
WORKDIR /root
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y ca-certificates \
    && update-ca-certificates

FROM scratch
COPY --from=root /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY main /app/bin/main
ENTRYPOINT ["/app/bin/main"]
