FROM weblate/weblate:5.1@sha256:7664cf1ff6116db1bf770826f4e97d9459d6d61235ac658e41358862ccc9905f

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
