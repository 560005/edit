FROM python:3.13-slim

WORKDIR /app

# Install sqlite3 for migrations
RUN apt-get update && apt-get install -y --no-install-recommends \
  sqlite3 \
  && rm -rf /var/lib/apt/lists/*

# Install datasette first
RUN pip install "datasette>=1.0a14"

# Install plugins using datasette install
RUN datasette install datasette-edit-schema
RUN datasette install datasette-auth-passwords
RUN datasette install datasette-search-all
RUN datasette install datasette-write-ui

# Create a directory for the database
RUN mkdir -p /app/data

# Copy project files
COPY . .

# Ensure scripts are executable
RUN chmod +x migrate_database

EXPOSE 8000

# Run migrations, then launch Datasette
CMD ["sh", "-c", "./migrate_database && datasette data.db --host 0.0.0.0 --port 8000 --cors --metadata metadata.yml --config datasette.yml --setting allow_download on"]
