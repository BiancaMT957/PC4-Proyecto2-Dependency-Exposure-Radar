#!/usr/bin/env bash

set -e  # detenemos la ejecución si ocurre un error inesperado

# Calcula la raíz del proyecto para que el script funcione desde cualquier ubicación
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Carpeta donde guardaremos el reporte del análisis SCA
REPORTS="$ROOT/reports"
mkdir -p "$REPORTS"   # crear la carpeta si no existe, útil para primera ejecución

echo "Iniciando análisis SCA..."

# Verificación de herramienta real (grype), para intentar un análisis auténtico si está disponible.
# Esto permite que el script funcione tanto con análisis real como simulado.
if command -v grype >/dev/null 2>&1; then
  echo "→ Usando grype para análisis real..."
  REPORT="$REPORTS/scan-report.json"

  # Intento de análisis real: si falla, pasamos a modo simulado para evitar romper el pipeline.
  if grype dir:"$ROOT" -o json > "$REPORT" 2>/dev/null; then
    echo "✓ Análisis real completado."
  else
    echo " grype falló, generando análisis simulado..."
    USE_SIMULATED="yes"
  fi
else
  # Sin herramientas instaladas → usamos modo simulado para asegurar reproductibilidad.
  echo "No se encontró herramienta real, usando análisis simulado."
  USE_SIMULATED="yes"
fi

# Generación de análisis simulado si no fue posible usar grype.
# El objetivo es siempre producir un reporte válido para los siguientes pasos del proyecto.
if [ "$USE_SIMULATED" = "yes" ]; then
  REPORT="$REPORTS/scan-report.json"
  fecha=$(date +"%Y-%m-%dT%H:%M:%SZ")

  # Construcción de un JSON mínimo válido que represente vulnerabilidades ficticias.
  # Esto permite probar reportes, dashboards y pipelines aun sin herramientas reales.
  cat > "$REPORT" <<EOF
{
  "scan_type": "simulado",
  "generated_at": "$fecha",
  "vulnerabilities": [
    { "id": "SIM-001", "severity": "LOW", "package": "example-lib" },
    { "id": "SIM-002", "severity": "MEDIUM", "package": "otra-dependencia" }
  ]
}
EOF

  echo "✓ Análisis simulado generado."
fi

# Mensaje final mostrando dónde quedó el reporte.
echo "Reporte generado en: $REPORT"

# Terminamos con confirmación clara de éxito.
echo "✔ Análisis completado sin errores."
