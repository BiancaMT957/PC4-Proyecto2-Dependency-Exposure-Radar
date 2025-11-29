#!/usr/bin/env bash
set -euo pipefail

# Ruta absoluta del directorio donde está este script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ruta del proyecto (raíz): un nivel arriba de scripts/
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# Obtener el short SHA del commit actual
GIT_SHA=$(git rev-parse --short HEAD)

echo "[INFO] Commit SHA detectado: $GIT_SHA"
echo "[INFO] Construyendo imágenes desde: $PROJECT_ROOT"

# Tags de las imágenes
API_IMAGE="auditor-api:${GIT_SHA}"
WORKER_IMAGE="auditor-worker:${GIT_SHA}"
REPORTER_IMAGE="auditor-reporter:${GIT_SHA}"

# Construir imágenes usando rutas absolutas
echo "[BUILD] API → ${API_IMAGE}"
docker build -t "${API_IMAGE}" "$PROJECT_ROOT/services/api"

echo "[BUILD] WORKER → ${WORKER_IMAGE}"
docker build -t "${WORKER_IMAGE}" "$PROJECT_ROOT/services/worker"

echo "[BUILD] REPORTER → ${REPORTER_IMAGE}"
docker build -t "${REPORTER_IMAGE}" "$PROJECT_ROOT/services/reporter"

echo "============================================="
echo "[OK] Todas las imágenes fueron construidas."
echo "Tags generados:"
echo "  - ${API_IMAGE}"
echo "  - ${WORKER_IMAGE}"
echo "  - ${REPORTER_IMAGE}"
echo "============================================="