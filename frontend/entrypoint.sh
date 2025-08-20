#!/bin/sh

set -e

echo "Starting Frontend Service..."

# For Development: Use npm start (hot-reload)
# exec npm start

# For Production: Serve the built static files
exec serve -s build -l 3000