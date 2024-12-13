import os
from fastapi import FastAPI, HTTPException, Request
from pydantic import BaseModel
import ros_api
import logging

# Inisialisasi FastAPI
app = FastAPI()

# Ambil API_KEY dari file .env
API_KEY = os.getenv("API_KEY", "default_api_key")

# Konfigurasi logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

# Model data input untuk command
class CommandRequest(BaseModel):
    host: str
    port: int = 8728
    user: str
    password: str
    command: str

# Endpoint untuk menjalankan command MikroTik
@app.get("/mikrotik/command")
async def execute_command(
    request: Request,
    host: str,
    port: int = 8728,
    user: str = "admin",
    password: str = "",
    command: str = "",
    plaintext_login: bool = False,
):
    # Validasi API Key
    authorization = request.headers.get("Authorization")
    if authorization != f"Bearer {API_KEY}":
        return {"status": False, "data": [], "message": "Invalid API Key"}

    # Koneksi ke MikroTik
    logger.debug(f"Menghubungkan ke MikroTik {host}:{port} dengan user {user}")
    try:
        # Koneksi ke RouterOS API tanpa parameter 'use_ssl'
        #address='192.168.10.1', user='Juri', password='L0vE$aun@', 
         #use_ssl=True, port=8730, verbose=False, context=ctx, timeout=1
        connection = ros_api.Api(
            address=host,
            user=user,
            password=password,
            use_ssl=False,
            port=port,
            verbose=False,
            context=None,
            timeout=1,
        )
        # api = connection.talk()

        # Eksekusi command
        logger.debug(f"Menjalankan command: {command}")
        response = connection.talk(command)

        logger.debug(f"Respon command: {response}")
        # connection.disconnect()

        return {"status": True, "data": response, "message": "Command berhasil dieksekusi"}
    except Exception as e:
        logger.error(f"Terjadi error: {e}")
        return {"status": False, "data": [], "message": str(e)}
