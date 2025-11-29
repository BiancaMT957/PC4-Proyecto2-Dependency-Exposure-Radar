# PC4-Proyecto2-Dependency Exposure Radar
 Dependency Exposure Radar

##  Descripción del proyecto
Dependency Exposure Radar es una herramienta local diseñada para equipos **DevSecOps** que necesitan responder rápidamente a la pregunta:

**“¿Qué dependencias y CVEs tengo en cada imagen Docker de mi proyecto?”**

El proyecto permite generar imágenes, obtener SBOMs, analizar dependencias y detectar versiones vulnerables de paquetes de forma simple, reproducible y sin depender de servicios externos.

---

##  Objetivo técnico

El proyecto implementa un flujo completo que incluye:

### **1. Imágenes Docker**
Varias pequeñas aplicaciones Python (por ejemplo: `api`, `worker`, `reporter`) cada una con:
- Dockerfiles endurecidos (slim/alpine)
- Multi-stage builds
- Uso de `USER` no root
- `.dockerignore` correcto

### **2. Scripts Bash**
Scripts dentro de `scripts/` permiten:
- Construir las imágenes con tags como `latest`, `dev`, `git-sha`
- Generar SBOMs locales usando:
  - `syft` o `CycloneDX` (si están disponibles)
  - Caso contrario, SBOM simulado
- Ejecutar escaneo SCA (Trivy/Grype o simulado)

### **3. Script Python `analyze_sboms.py`**
Ubicado en `scripts/` o raíz del proyecto, este script:
- Lee todos los SBOMs de la carpeta `sboms/`
- Identifica:
  - Dependencias repetidas entre imágenes
  - Versiones vulnerables
  - Paquetes desactualizados
  - Paquetes críticos presentes en múltiples imágenes

### **4. Carpetas del proyecto**
services/ # Apps Python (api, worker, reporter)
scripts/ # Scripts Bash + analyze_sboms.py
sboms/ # Archivos SBOM generados
reports/ # Reportes de vulnerabilidades
docs/ # Documentación del proyecto

##  Cómo comenzar

1. Clonar el repositorio
2. Ejecutar scripts de construcción
bash scripts/build_images.sh

3. Generar SBOMs:

```
bash scripts/generate_sboms.sh
```

4. Ejecutar análisis:

```
python3 analyze_sboms.py
```

---

##  Estado del proyecto
* Estructura base creada
* Scripts Bash en desarrollo
* Dockerfiles endurecidos
* Integración con scanners
* Pipeline CI/CD

---

##  Documentación
Toda documentación adicional se encuentra en `docs/`.

---

##  Licencia
Libre uso para fines educativos.

## Automatizacion
Se creo el archivo `makefile` para automatizar la ejecucion siguiendo los siguientes comandos:
```bash
# Ejecuta build-all.sh
make build

# Genera SBOMs para las imagenes de nuestro servicios
make sbom

# Analisis SCA
make scan
```