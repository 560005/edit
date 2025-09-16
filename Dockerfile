FROM python:3.11-slim

WORKDIR /app

# Install datasette and plugins
RUN pip install datasette \
  datasette-publish-fly \
  datasette-edit-schema \
  datasette-auth-github \
  datasette-insert

# Create a directory for the database
RUN mkdir -p /app/data

# Copy configuration and any existing databases
COPY . .

# Create metadata file if it doesn't exist
RUN touch metadata.json

EXPOSE 8000

# Start datasette with metadata
CMD ["datasette", ".", "--host", "0.0.0.0", "--port", "8000", "--cors", "--metadata", "metadata.json"]
