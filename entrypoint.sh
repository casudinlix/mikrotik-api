#!/bin/bash

# Load .env file
if [ -f .env ]; then
  export $(cat .env | xargs)
fi

# Gunakan port dari HTTP_PORT, atau fallback ke 5050 jika tidak ada
HTTP_PORT=${HTTP_PORT:-5050}

echo "Starting FastAPI server on port $HTTP_PORT"

# Jalankan Uvicorn dengan port yang diambil dari HTTP_PORT
exec uvicorn mikrotik_api:app --host 0.0.0.0 --port $HTTP_PORT
