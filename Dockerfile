FROM python:3.11-slim

WORKDIR /app

# Install datasette and any plugins you want
RUN pip install datasette datasette-publish-fly

# Copy your data (if you have any)
# COPY your-database.db /app/

EXPOSE 8000

CMD ["datasette", ".", "--host", "0.0.0.0", "--port", "8000"]
