FROM python:3.13-slim

WORKDIR /app

RUN pip install "datasette>=1.0a14"
RUN datasette install \
    datasette-edit-schema \
    datasette-auth-passwords \
    datasette-search-all \
    datasette-write-ui

COPY . .

EXPOSE 8000

CMD ["datasette", "data.db", "--host", "0.0.0.0", "--port", "8000", "--cors", "--metadata", "metadata.yml", "--config", "datasette.yml"]
