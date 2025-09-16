FROM python:3.11-slim

WORKDIR /app

# Install datasette and plugins
RUN pip install \
  datasette \
  datasette-publish-fly \
  datasette-edit-schema \
  datasette-auth-github \
  datasette-insert

# Create a directory for the database
RUN mkdir -p /app/data

# Copy project files (code, config, migrations, scripts)
COPY . .

# Ensure scripts are executable
RUN chmod +x migrate_db

EXPOSE 8000

# Run migrations, then launch Datasette
CMD ["sh", "-c", "./migrate.sh && datasette data.db --host 0.0.0.0 --port 8000 --cors --metadata metadata.json"]
