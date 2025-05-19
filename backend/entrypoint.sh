#!/usr/bin/env bash
set -e

# Wait on DB here if you add one
# until nc -z db 5432; do sleep 1; done

python manage.py migrate --no-input
python manage.py collectstatic --no-input

exec gunicorn backend.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3
