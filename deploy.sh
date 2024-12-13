#!/bin/bash

echo "Membangun container baru..."
docker-compose --project-name mikrotik-api build || {
    echo "Gagal membangun container. Menghentikan proses."
    exit 1
}

echo "Berhasil membangun container mikroti api."
# Hentikan dan hapus container lama sebelum build
echo "Menghentikan dan menghapus container lama..."
 docker-compose --project-name mikrotik-api stop mikrotik-api  || echo "Container tidak aktif."
 docker-compose --project-name mikrotik-api rm -f mikrotik-api  || echo "Container lama sudah dihapus."

# Start ulang container
echo "Memulai container baru..."
docker-compose --project-name mikrotik-api up --remove-orphans  --no-deps --force-recreate  -d || {
    echo "Gagal menyalakan container. Menghentikan proses."
    exit 1
}

docker-compose ps
