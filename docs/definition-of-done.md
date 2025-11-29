# Proyecto Dependency Exposure Radar

## Ítems Mínimos para Considerar una Historia en Done
Según nuestra rubrica, una historia sólo pasa a Done si cumple:

### 1. Calidad Técnica
- Código Python y Bash sin errores.
- Dockerfiles multi-stage y seguros (USER no root).
- `.dockerignore` aplicado correctamente.

### 2. Pruebas
- `make test` ejecuta sin fallos.
- Scripts Bash ejecutan sin pasos manuales adicionales.

### 3. Seguridad
- SBOM generado correctamente.
- Scan SCA completado.
- Evidencias en `sboms/` y `reports/` generadas.

### 4. Documentación
- README actualizado.
- Comentarios en español en Bash/Python.
- Sin TODO críticos sin justificar.

### 5. Git y Flujo
- Commit limpio sin secretos.
- Rama feature mergeada por PR.
- Tarjeta movida a Done en GitHub Projects.

### 6. Reproducibilidad
- Cualquier persona debe poder ejecutar:
  ```bash
  make build
  make sbom
  make scan


# Evidencias 

## Issue 1

![captura](issue1.png)

## Issue 2


![captura](issue2.1.png)

![captura](issue2.2.png)

## Issue 3

![captura](issue3.png)

## Issue 4

![captura](issue4.png)

## Issue 5

![captura](issue5.1.png)

![captura](issue5.2.png)

![captura](issue5.3.png)

## Issue 6
![captura](issue6.1.png)

![captura](issue6.2.png)

## Issue 7
![captura](issue7.png)

![captura](issue7.1.png)

![captura](issue7.2.png)

![captura](issue7.3.png)

## Issue 7
![captura](issue8.png)

![captura](issue8.1.png)