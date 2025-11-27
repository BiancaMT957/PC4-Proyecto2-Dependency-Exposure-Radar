# services/worker/app.py
import time

def process_message(msg):
    print(f"[worker] Procesando mensaje: {msg}")
    time.sleep(1)
    print("[worker] Trabajo finalizado.")

if __name__ == "__main__":
    print("[worker] Iniciando Worker...")
    process_message("Hola desde Worker")
