# Gunakan image Python sebagai base
FROM python:3.9-slim

# Set working directory di dalam container
WORKDIR /app

# Salin file requirements terlebih dahulu untuk memanfaatkan caching Docker
COPY requirements.txt /app/requirements.txt

# Install dependencies hanya jika requirements.txt berubah
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r /app/requirements.txt


# Salin seluruh file aplikasi ke container
COPY . /app
# Salin entrypoint.sh dan berikan izin eksekusi
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Ekspos port untuk aplikasi
EXPOSE 5050

# Jalankan aplikasi menggunakan entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
