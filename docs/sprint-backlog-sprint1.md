# Issue 1 — Crear estructura base del proyecto 
## ID=1
## Descripción corta
Crear la estructura inicial del repositorio siguiendo exactamente las carpetas y archivos requeridos para el Proyecto 2 – Dependency Exposure Radar.

## Criterios de aceptación
- Estructura creada exactamente como exige el Proyecto 2.
- Sin carpetas extra.
- README.md mínimo añadido.
- Repositorio listo para comenzar a agregar servicios.

## Responsable(s)
Bianca Merchán Torres

## Resultado (Implementación)

Se creó la estructura inicial del proyecto:
services/
scripts/
docs/
sboms/
reports/
README.md
.gitignore


El archivo README.md contiene:
- Nombre del proyecto  
- Objetivo  
- Descripción general del flujo DevSecOps  
- Estructura del proyecto  

Se añadió un `.gitignore` optimizado para:
- Python  
- Scanners (syft, trivy, grype)  
- Archivos de SBOMs y reportes  
- Docker  
- Cachés  
- Entornos virtuales  


---

# Issue 2 — Implementar servicio API (app mínima Python) 
## ID=2
## Descripción corta
Crear un servicio Python mínimo llamado API, ubicado en `services/api/`, con una aplicación funcional usando Flask y un `requirements.txt` liviano.

## Criterios de aceptación
- La app ejecuta sin errores.
- Solo utiliza Flask, FastAPI o print simple.
- `requirements.txt` pequeño.
- Ubicación correcta:
  - `services/api/app.py`
  - `services/api/requirements.txt`
- Rama de trabajo: `feature/api-service`

## Responsable(s)
Bianca Merchán Torres

## Resultado (Implementación)

### 1) Servicio creado
`services/api/app.py`:

```python
from flask import Flask

app = Flask(__name__)

@app.get("/")
def root():
    return {"message": "Dependency Exposure Radar - API running"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
```
### 2)Dependencias mínimas

services/api/requirements.txt:
flask==3.0.2

### 3) Ejecución local verificada

Comandos usados:

```
python app.py
```


En la primera terminal:


```
(venv) bianca007@MSI:/mnt/c/Users/Bianca/Documents/PC4-Proyecto2-Dependency-Exposure-Radar/services/api$ python3 app.py
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:8080
 * Running on http://172.22.75.112:8080
Press CTRL+C to quit
127.0.0.1 - - [22/Nov/2025 17:28:06] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [22/Nov/2025 17:28:41] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [22/Nov/2025 17:28:46] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [22/Nov/2025 17:30:50] "GET / HTTP/1.1" 200 -
```



En 2da terminal:

```
bianca007@MSI:/mnt/c/Users/Bianca/Documents/PC4-Proyecto2-Dependency-Exposure-Radar$ source venv/bin/activate
(venv) bianca007@MSI:/mnt/c/Users/Bianca/Documents/PC4-Proyecto2-Dependency-Exposure-Radar$ curl http://localhost:8080/
{"message":"Dependency Exposure Radar - API running"}
```

En la pagina http://localhost:8080/ se tiene:

{"message":"Dependency Exposure Radar - API running"}



# Issue 3 — Implementar servicio Worker
## ID=3

## Descripción corta

Crear el servicio Worker, ubicado en services/worker/, que ejecute una función simple (por ejemplo, procesar un mensaje o imprimir) y contar con su propio requirements.txt (vacío o mínimo).

## Criterios de aceptación

El Worker ejecuta sin errores.

app.py contiene una función simple (procesar mensaje / print).

El servicio se puede ejecutar con:

python app.py

requirements.txt creado (vacío o con dependencias mínimas).

Ubicación correcta:

services/worker/app.py

services/worker/requirements.txt

Rama de trabajo: feature/worker-service

## Responsable(s)

Bianca Merchán Torres

## Ejecución

bianca007@MSI:/mnt/c/Users/Bianca/Documents/PC4-Proyecto2-Dependency-Exposure-Radar/services/worker$ python3 app.py [worker] Iniciando Worker... [worker] Procesando mensaje: Hola desde Worker [worker] Trabajo finalizado.


# Issue 4 — Implementar servicio Reporter
## ID=4
## Descripción corta

Crear el servicio Reporter, ubicado en services/reporter/, que ejecuta una función mínima para indicar que el sistema está listo para leer reportes o SBOMs. Incluir un requirements.txt liviano (vacío en este caso).

## Criterios de aceptación

app.py ejecuta sin errores.

Contiene una función simple o impresión placeholder.

requirements.txt creado y mínimo (puede estar vacío).

Ubicación correcta del servicio:

services/reporter/app.py

services/reporter/requirements.txt


## Responsable(s)

Bianca Merchán Torres


## Ejecución


```
(venv) bianca007@MSI:/mnt/c/Users/Bianca/Documents/PC4-Proyecto2-Dependency-Exposure-Radar/services/reporter$ python3 app.py
[reporter] Iniciando Reporter...
[reporter] Servicio listo para leer reportes o SBOMs.
```

# Issue 5 - Crear Dockerfiles multi-stage para cada servicio
## ID=5
## Descripcion
Crear Dockerfiles para api, worker y reporter usando imágenes slim o alpine y multi-stage build.

## Criterios de aceptacion
- No usar `:latest`: Cuando hacemos
  ```bash
  FROM python:latest # Solicita la version más reciente y estable de Python (no es fijo)
  ```
  No garantiza reproducibilidad, que es lo que buscamos.
  Solucion:
  ```bash
  FROM python:3.12-slim-bookworm # Version fija
  ```
  Aqui tambien cumplimos el uso de imagenes `slim` o alpine:
    - `slim`: variante reducida de Debian (menos paquetes, menos peso).
    - `bookworm`: nombre de la version de Debian base.

  Tambien podriamos usar `python:3.12-alpine`, pero con `slim` ya cubrimos los requerimientos necesarios.

- `USER no-root`: Por defecto, los contenedores corren como root, lo cual es un riesgo:
  - compromete el host si alguien escapa del contenedor
  - viola prácticas DevSecOps
  - muchas auditorías lo rechazan

  Solucion:
  ```bash
  RUN useradd -m appuser && chown -R appuser /app
  USER appuser
  ```
- `.dockerignore` correcto: evita que Docker copie basura al contexto cuando se hace
  ```nginx
  docker build .
  ```
- Multi-stage funcionando: Se compone de 2 stages (builder y runtime).
  ```dockerfile
  # Instala dependencias
  FROM python:3.12-slim-bookworm AS builder
  # Copia lo necesario para la ejecucion
  FROM python:3.12-slim-bookworm AS runtime
  ```

## Responsable
Luis Calapuja

## Implementacion
```dockerfile
# Stage 1: builder
# Carpeta de trabajo
WORKDIR /app
# Crea entorno virtual en el contenedor
RUN python -m venv /opt/venv
# Añade PATH para usar pip del venv
ENV PATH="/opt/venv/bin:${PATH}"
# Copia requirements e instala dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Copia el codigo del servicio
COPY . .
```

```dockerfile
# Stage 2: runtime
# Config el entorno de ejecucion (sin .pyc ni buffer)
ENV PATH="/opt/venv/bin:${PATH}"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# Copia venv instalado y codigo
COPY --from=builder /opt/venv /opt/venv
COPY --from=builder /app /app
# Crea usuario no-root
RUN useradd -m appuser && chown -R appuser /app
USER appuser
# Ejecuta el servicio
CMD ["python", "app.py"]
```

## Ejecucion
Desde la ubicacion de cada archivo dockerfile haremos lo siguiente:
```bash
# API Flask
cd services/api
docker build -t auditor-api:0.1 .
docker run -p 8080:8080 auditor-api:0.1
```
Se verifica en el navegador: `http://localhost:8080/`

```bash
# worker
cd services/worker
docker build -t auditor-worker:0.1 .
docker run auditor-worker:0.1
```
```bash
# reporter
cd services/reporter
docker build -t auditor-reporter:0.1 .
docker run auditor-reporter:0.1

```