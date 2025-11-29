# Registro de Riesgos — Dependency Exposure Radar

| ID | Riesgo | Probabilidad | Impacto | Mitigación | Estado |
|----|--------|--------------|----------|------------|--------|
| R1 | Dependencias vulnerables en servicios Python | Alto | Alto | Ejecutar SBOM + SCA cada sprint | Abierto |
| R2 | Imágenes Docker demasiado pesadas | Medio | Medio | Usar python:3.12-slim + multi-stage | Cerrado |
| R3 | Usuarios root en contenedores | Alto | Alto | Configurar USER no root en todos los Dockerfiles | Cerrado |
| R4 | Scripts Bash fallan silenciosamente | Medio | Alto | Usar `set -euo pipefail` | Cerrado |
| R5 | Métricas no recopiladas a tiempo | Bajo | Medio | Registrar al final de cada día | Abierto |
| R6 | SBOM incompleto o corrupto | Medio | Alto | Validar formato antes de analyze_sboms.py | Abierto |
| R7 | Sobrecarga de tareas en Sprint 2 | Medio | Medio | Respetar WIP < 3 | En seguimiento |
