FROM python:3.13-slim

WORKDIR /app

# Install sqlite3 for migrations
RUN apt-get update && apt-get install -y --no-install-recommends \
  sqlite3 \
  && rm -rf /var/lib/apt/lists/*

# Install datasette first
RUN pip install datasette

# Install plugins using datasette install
RUN datasette install datasette-edit-schema
RUN datasette install datasette-auth-github
RUN datasette install datasette-insert

# Create a directory for the database
RUN mkdir -p /app/data

# Copy project files (code, config, migrations, scripts)
COPY . .

# Ensure scripts are executable
RUN chmod +x migrate_db

EXPOSE 8000

# Run migrations, then launch Datasette
CMD ["sh", "-c", "./migrate_db && datasette data.db --host 0.0.0.0 --port 8000 --cors --metadata metadata.json"]
