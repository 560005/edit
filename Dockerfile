FROM python:3.13-slim

WORKDIR /app

RUN pip install "datasette>=1.0a14"
RUN datasette install \
    datasette-edit-schema \
    datasette-auth-passwords \
    datasette-search-all \
    datasette-write-ui

COPY . .
COPY data.db /app/data.db

EXPOSE 8000

CMD ["sh", "-c", "cp -n /app/data.db /app/data/data.db && datasette /app/data/data.db --host 0.0.0.0 --port 8000 --cors --metadata metadata.yml --config datasette.yml"]
