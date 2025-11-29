# Visión del Proyecto — Dependency Exposure Radar

## 1. Contexto
Este proyecto nace de una necesidad frecuente en equipos DevSecOps: **visualizar rápidamente qué dependencias, paquetes, imágenes y CVEs existen dentro de un ecosistema de contenedores**, todo de forma **local**, sin depender de servicios externos ni cloud providers.

El proyecto debe simular un entorno real DevSecOps donde se combinen prácticas de build usando dockerfiles, análisis de seguridad, SBOM, scripting Bash y automatización.

Dependency Exposure Radar replica un caso común en empresas donde cada equipo produce múltiples servicios Dockerizados (API, Worker, Reporter), pero **nadie sabe exactamente qué dependencias tienen, qué paquetes se repiten, y cuáles presentan vulnerabilidades**.

## 2. Problema que Resuelve
El proyecto busca responder preguntas críticas:

- ¿Qué dependencias existen en cada imagen Docker?
- ¿Qué librerías se repiten innecesariamente?
- ¿Qué versiones vulnerables están siendo usadas?
- ¿Se puede automatizar la generación de SBOM y análisis SCA localmente?

Sin una herramienta local, el equipo DevSecOps pierde tiempo revisando contenedor por contenedor.

## 3. Alcance
El proyecto incluye:

- **Tres servicios Python mínimos**: API, Worker, Reporter.
- **Imágenes Docker multi-stage**, con:
  - `python:3.12-slim`
  - `USER` no root
  - `.dockerignore` estrictos
- **Scripts Bash** que realizan:
  - Build completo con tag basado en `git rev-parse --short HEAD`
  - Generación de SBOM
  - Ejecución de scans SCA (real o simulado)
- **Script Python** `analyze_sboms.py` que:
  - Analiza múltiples SBOM en `/sboms`
  - Detecta dependencias repetidas
  - Enumera vulnerabilidades y dependencias críticas


## 4. Objetivos Técnicos
- Implementar Dockerfiles multi-stage seguros.
- Aplicar buenas prácticas DevSecOps locales.
- Automatizar builds con tags inmutables.
- Generar SBOM locales (CycloneDX o simulación).
- Ejecutar escaneo SCA automatizado.
- Crear un analizador Python para agregación de resultados.
- Mantener reproducibilidad con `Makefile` y scripts Bash.

## 5. Objetivos de Aprendizaje
- Comprender el flujo completo DevSecOps (construcción → análisis → reporte).
- Dominar scripting Bash usando `set -euo pipefail`.
- Aprender a construir imágenes compactas y seguras.
- Entender qué es un SBOM y por qué es crítico en seguridad.
- Practicar métricas ágiles (throughput, lead time, WIP).
- Producir documentación técnica clara y reproducible.

## 6. Inspiración Real
Este laboratorio se inspira en un escenario real común:  
> “Un equipo DevSecOps de una empresa de software necesitaba una forma rápida y totalmente local de identificar dependencias vulnerables dentro de muchas imágenes Docker. Sin cloud, sin herramientas externas, todo debía ejecutarse localmente por restricciones de seguridad.”

Dependency Exposure Radar replica exactamente ese entorno.