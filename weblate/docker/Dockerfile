FROM weblate/weblate:5.1

# Self-signed cert used for HTTPS between the load balancer and ECS task
RUN mkdir -p /app/data/ssl \
    && chown weblate:1000 /app/data/ssl \
    && openssl req -x509 \
        -newkey rsa:4096 \
        -keyout /app/data/ssl/privkey.pem \
        -out /app/data/ssl/fullchain.pem \
        -sha256 \
        -days 3650 \
        -nodes \
        -subj "/C=CA/ST=Ontario/L=Ottawa/O=Government of Canada/OU=Canadian Digital Service/CN=localhost" \
    && chmod 600 /app/data/ssl/*.pem

USER 1000
