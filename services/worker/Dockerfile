# Stage 1: build (instalar dependencias)
FROM python:3.12-slim-bookworm AS builder

# No usamos :latest → versión fija
WORKDIR /app

# Crear entorno virtual dentro de la imagen
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:${PATH}"

# Copiamos solo requirements primero para aprovechar caché
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el código de este servicio
COPY . .

# Stage 2: runtime
FROM python:3.12-slim-bookworm AS runtime

# Usar el venv del stage anterior
ENV PATH="/opt/venv/bin:${PATH}"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Copiar entorno virtual ya listo
COPY --from=builder /opt/venv /opt/venv

# Copiar código del servicio
COPY --from=builder /app /app

# Crear usuario no-root
RUN useradd -m appuser && chown -R appuser /app

USER appuser

# CMD segun servicio
CMD ["python", "app.py"]