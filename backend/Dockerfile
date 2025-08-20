FROM python:3.11-slim-bullseye

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install system dependencies required for building Python packages & MySQL client
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project and entrypoint
COPY . .
COPY ./entrypoint.sh /
COPY ./celery-entrypoint.sh /

# Make entrypoint scripts executable
RUN chmod +x /entrypoint.sh /celery-entrypoint.sh

# Expose the port the app runs on
EXPOSE 8000

# The default command that runs when the container starts.
# This can be overridden in docker-compose.yml.
CMD ["/entrypoint.sh"]