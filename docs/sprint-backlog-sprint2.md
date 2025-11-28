# Issue 6 - Crear script Bash `build-all.sh` 
## ID=6
## Descripción corta
Script que construya las imágenes con tag basado en `git rev-parse --short HEAD`.

## Criterios de aceptación
- Ejecuta sin errores.
- Da tags correctos.
- Usa set -euo pipefail

## Responsable(s)
Luis Calapuja

## Resultado (Implementación)
Se creo `build-all.sh` en la raiz del proyecto para poder ejecutarse directamente. Donde asignaremos un tag usando SHA sobre el `git rev-parse...`
```bash
# Obtener el short SHA del commit actual
GIT_SHA=$(git rev-parse --short HEAD)
```

Y lo asignaremos a las imagenes:
```bash
# Tags de las imágenes
API_IMAGE="auditor-api:${GIT_SHA}"
WORKER_IMAGE="auditor-worker:${GIT_SHA}"
REPORTER_IMAGE="auditor-reporter:${GIT_SHA}"
```

## Ejecucion
```bash
chmod +x build-all.sh
./build-all.sh
```

#  Issue 7 — Script `generate-sboms.sh` (real o simulado)

**ID:** 7  
**Responsable:** Bianca Merchán Torres  

##  Descripción corta

Crear el script `generate-sboms.sh` dentro de `scripts/` que genere un SBOM por cada servicio ubicado en `services/`.

El script debe:

- Usar **Syft** si está instalado.
- Si no está disponible, generar un **SBOM simulado** en formato JSON válido.
- Guardar todos los SBOMs en la carpeta `sboms/`.

---

##  Criterios de aceptación

- Se genera **1 SBOM por cada servicio** dentro de `services/`.
- El SBOM generado es **JSON válido** (validado con `jq` si existe).
- Cada SBOM se guarda en sboms/<servicio>.json
- El script soporta dos modos automáticamente:
- **Modo real:** usa Syft si está instalado.
- **Modo simulado:** genera un SBOM simple en JSON si Syft no está.
- El formato del SBOM debe ser **consistente** entre servicios.
- El script se ejecuta con:./scripts/generate-sboms.sh
y no debe fallar en: entornos virtuales, WSL, ni configuraciones distintas del usuario.Código simple y sin quitar funcionalidades.

---

##  Ubicación requerida


---

##  Ejecución esperada

```bash
(venv) bianca007@MSI:/mnt/.../scripts$ ./generate-sboms.sh
Generando SBOMs...
Directorio de servicios: /mnt/.../services
Salida: /mnt/.../sboms

Servicio: api
  -> Generando SBOM simulado
  -> JSON válido ✔

Servicios encontrados: 1
SBOMs válidos: 1
✔ Todo OK
```

Contenido generado en sboms/api.json:

```
{
  "sbom_format": "simulado",
  "name": "api",
  "generated_at": "2025-11-28T09:32:31Z",
  "files": [
    { "path": "app.py", "size": 217 }
,
    { "path": "Dockerfile", "size": 934 }
,
    { "path": "requirements.txt", "size": 14 }
  ]
}
```

De la misma manera hay salidas  para reporter.json y worker.json


#  Issue 8 — Script `run-scan.sh` (SCA simulado o real)

**ID:** 8  
**Responsable:** Bianca Merchán Torres  
**Rama de trabajo:** `feature/run-scan/Bianca`

---

##  Descripción corta

Crear un script `run-scan.sh` dentro de la carpeta `scripts/` que ejecute un análisis SCA (real o simulado) sobre las dependencias del proyecto y genere un archivo JSON con los resultados.

El análisis debe:

- Guardar el resultado en `reports/`
- Ejecutarse sin errores en cualquier entorno
- Usar herramientas reales (como **grype**) si están instaladas
- Si no, generar un análisis **simulado**

---

##  Criterios de aceptación

- El script genera un archivo **JSON válido** dentro de `reports/`.
- La ejecución no produce errores.
- El análisis puede ser:
  - **Real:** si existe una herramienta instalada (p. ej., `grype`)
  - **Simulado:** si no se encuentra ninguna herramienta disponible
- Nombre del archivo generado: ´reports/scan-report.json


- El script debe imprimir **logs simples**, como:
- inicio
- tipo de análisis
- resultado final

---

##  Ubicación esperada: 
scripts/run-scan.sh
reports/scan-report.json


---

##  Ejecución esperada

**Comando:**

```bash
./scripts/run-scan.sh
```

## Salida esperada (ejemplo):

```
(venv) bianca007@MSI:/mnt/c/Users/Bianca/Documents/PC4-Proyecto2-Dependency-Exposure-Radar/scripts$ ./run-scan.sh
Iniciando análisis SCA...
No se encontró herramienta real, usando análisis simulado.
✓ Análisis simulado generado.
Reporte generado en: /mnt/c/Users/Bianca/Documents/PC4-Proyecto2-Dependency-Exposure-Radar/repReporte generado en: /mnt/c/Users/Bianca/Documents/PC4-Proyecto2-Dependency-Exposure-Radar/reports/scan-report.json
✔ Análisis completado sin errores.
```

Además dentro de la carpeta reports/

```
{
  "scan_type": "simulado",
  "generated_at": "2025-11-28T10:16:09Z",
  "vulnerabilities": [
    { "id": "SIM-001", "severity": "LOW", "package": "example-lib" },
    { "id": "SIM-002", "severity": "MEDIUM", "package": "otra-dependencia" }
  ]
}
```



