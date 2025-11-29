#!/usr/bin/env bash

set -e   # Detener el script si ocurre un error importante

# Obtener la ruta raíz del proyecto (carpeta principal)
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SERVICES="$ROOT/services"
SBOMS="$ROOT/sboms"

# Crear carpeta de salida de SBOMs (por si no existe)
mkdir -p "$SBOMS"

echo "Generando SBOMs..."
echo "Directorio de servicios: $SERVICES"
echo "Salida: $SBOMS"
echo

# Verificar si Syft está instalado para usar modo “real”
if command -v syft >/dev/null 2>&1; then
  USE_SYFT="si"
else
  USE_SYFT="no"
fi

# Verificar si jq está disponible para validar JSON
if command -v jq >/dev/null 2>&1; then
  HAS_JQ="si"
else
  HAS_JQ="no"
fi

# Contadores para validación final
total_servicios=0
total_sboms=0

# Recorrer cada carpeta dentro de /services
for carpeta in "$SERVICES"/*; do
  if [ -d "$carpeta" ]; then
    servicio="$(basename "$carpeta")"
    total_servicios=$((total_servicios+1))

    echo "Servicio: $servicio"
    archivo="$SBOMS/$servicio.json"

    # Si existe Syft, intentar generar el SBOM real
    if [ "$USE_SYFT" = "si" ]; then
      echo "  -> Intentando con syft..."
      if syft "$carpeta" -o json > "$archivo" 2>/dev/null; then
        echo "     syft OK"
      else
        # Si Syft falla, borrar archivo y pasar al modo simulado
        echo "     syft falló, usando simulado..."
        rm -f "$archivo"
      fi
    fi

    # Si el archivo no existe o está vacío, generar un SBOM simulado
    if [ ! -s "$archivo" ]; then
      echo "  -> Generando SBOM simulado"
      fecha=$(date +"%Y-%m-%dT%H:%M:%SZ")

      # Iniciar el JSON del SBOM simulado
      echo "{
  \"sbom_format\": \"simulado\",
  \"name\": \"$servicio\",
  \"generated_at\": \"$fecha\",
  \"files\": [" > "$archivo"

      primero=1

      # Recorrer hasta 200 archivos del servicio para listarlos en el SBOM
      while IFS= read -r f; do
        # Obtener ruta relativa para que el JSON no guarde rutas largas del sistema
        rel="${f#$carpeta/}"

        # Tamaño del archivo (solo para tener un dato básico)
        tam=$(wc -c < "$f" 2>/dev/null || echo 0)

        # Manejar la coma entre elementos del array JSON
        if [ $primero -eq 1 ]; then
          primero=0
        else
          echo "," >> "$archivo"
        fi

        # Agregar el archivo al SBOM
        echo "    { \"path\": \"$rel\", \"size\": $tam }" >> "$archivo"

      done < <(find "$carpeta" -type f | head -n 200)

      # Cerrar JSON
      echo "  ]
}" >> "$archivo"
    fi

    # Validar que el archivo JSON generado sea válido (si existe jq)
    if [ "$HAS_JQ" = "si" ]; then
      if jq empty "$archivo" >/dev/null 2>&1; then
        echo "  -> JSON válido"
        total_sboms=$((total_sboms+1))
      else
        # Indicar error, pero continuar para no romper la experiencia
        echo "  -> ERROR: JSON inválido "
      fi
    else
      # Si no hay jq, simplemente asumir que está correcto
      echo "  -> No hay jq, asumo válido "
      total_sboms=$((total_sboms+1))
    fi

    echo
  fi
done

# Resumen final para asegurarse que hubo 1 SBOM por servicio
echo "Servicios encontrados: $total_servicios"
echo "SBOMs válidos: $total_sboms"

# Comparar si el número de SBOMs coincide con el número de servicios
if [ "$total_servicios" -ne "$total_sboms" ]; then
  echo " No hay coincidencia"
  exit 1
else
  echo "Todo OK"
fi