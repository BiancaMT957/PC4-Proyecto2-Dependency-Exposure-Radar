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












