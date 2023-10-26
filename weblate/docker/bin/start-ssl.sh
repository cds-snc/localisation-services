#!/bin/sh

COMMAND="$1"

echo "Moving SSL certificates into the shared volume..."
mkdir -p /app/data/ssl
mv /tmp/ssl/*.pem /app/data/ssl/

# Start Weblate
echo "Starting Weblate $COMMAND..."
/app/bin/start "$COMMAND"
