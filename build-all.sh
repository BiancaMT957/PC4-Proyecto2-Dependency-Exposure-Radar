#!/usr/bin/env bash
set -euo pipefail

# Obtener el short SHA del commit actual
GIT_SHA=$(git rev-parse --short HEAD)

echo "[INFO] Commit SHA detectado: $GIT_SHA"
echo "[INFO] Construyendo imágenes..."

# Tags de las imágenes
API_IMAGE="auditor-api:${GIT_SHA}"
WORKER_IMAGE="auditor-worker:${GIT_SHA}"
REPORTER_IMAGE="auditor-reporter:${GIT_SHA}"

# Construir imágenes (desde raíz del repo)
echo "[BUILD] API → ${API_IMAGE}"
docker build -t "${API_IMAGE}" services/api

echo "[BUILD] WORKER → ${WORKER_IMAGE}"
docker build -t "${WORKER_IMAGE}" services/worker

echo "[BUILD] REPORTER → ${REPORTER_IMAGE}"
docker build -t "${REPORTER_IMAGE}" services/reporter

echo "============================================="
echo "[OK] Todas las imágenes fueron construidas."
echo "Tags generados:"
echo "  - ${API_IMAGE}"
echo "  - ${WORKER_IMAGE}"
echo "  - ${REPORTER_IMAGE}"
echo "============================================="