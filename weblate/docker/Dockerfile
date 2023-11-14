FROM weblate/weblate:5.1@sha256:03b8337d4c5b2e3679f0e312d4104e532485e97121bbd72b740ff0c1d830ad41

# Self-signed cert used for HTTPS between the load balancer and ECS task
RUN mkdir -p /tmp/ssl \
    && chown 1000:1000 /tmp/ssl \
    && openssl req -x509 \
        -newkey rsa:4096 \
        -keyout /tmp/ssl/privkey.pem \
        -out /tmp/ssl/fullchain.pem \
        -sha256 \
        -days 3650 \
        -nodes \
        -subj "/C=CA/ST=Ontario/L=Ottawa/O=Government of Canada/OU=Canadian Digital Service/CN=localhost" \
    && chmod 600 /tmp/ssl/*.pem

COPY --chown=1000:1000 bin/start-ssl.sh /app/bin/start-ssl

USER 1000

ENTRYPOINT ["/app/bin/start-ssl"]
CMD ["runserver"]
