#!/bin/sh

set -e

# Wait for the backend to be fully up if needed (though depends_on handles most of it)
# sleep 10

echo "Running Celery command: $@"
exec celery -A your_project.celery:app $@