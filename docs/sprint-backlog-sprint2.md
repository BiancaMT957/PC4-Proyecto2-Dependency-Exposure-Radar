# Issue 6 - Crear script Bash `build-all.sh` 
## ID=1
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