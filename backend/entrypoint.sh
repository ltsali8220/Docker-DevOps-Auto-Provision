#!/bin/sh

set -e  # Exit immediately if a command exits with a non-zero status.

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate --noinput

# Collect static files (for serving later via Nginx)
echo "Collecting static files..."
python manage.py collectstatic --noinput --clear

# Create a superuser non-interactively (ONLY for development!)
# For production, remove this or use a better method.
echo "Creating default superuser if needed..."
python manage.py shell -c "
from django.contrib.auth import get_user_model;
User = get_user_model();
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'adminpass')
" || echo "Superuser creation skipped or failed."

# Start Gunicorn to serve the Django application
echo "Starting Gunicorn..."
exec gunicorn your_project.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --worker-class gevent \
    --log-level info