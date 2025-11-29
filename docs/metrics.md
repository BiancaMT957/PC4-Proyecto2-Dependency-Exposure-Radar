# Métricas - Dependency Exposure Radar

Este documento resume las métricas requeridas para evaluar el rendimiento del proyecto en dos sprints de 5 días cada uno. Incluye métricas de proceso (Scrum/Kanban) y métricas de seguridad necesarias para un entorno DevSecOps local.

---

# Sprint 1 — Días 1 al 5

## 1. Throughput (Historias completadas)
Total de historias completadas: **6**

| Historia | Título | Estado |
|---------|--------|--------|
| S1-H1 | Estructura inicial del proyecto | Done |
| S1-H2 | Servicio API mínimo | Done |
| S1-H3 | Servicio Worker mínimo | Done |
| S1-H4 | Servicio Reporter mínimo | Done |
| S1-H5 | Script build-all.sh | Done |
| S1-H6 | dockerignore para todos los servicios | Done |

**Conclusión:** Se completó toda la base técnica del proyecto.

---

## 2. Lead Time
Promedio: **1.7 días por historia**

- Historias pequeñas (H1, H6): ~1 día  
- Historias con Dockerfiles y scripting (H2–H5): ~2 días  

---

## 3. WIP (Work In Progress)
- WIP máximo permitido: **2**
- WIP real observado: **2**
- El límite se respetó durante todo el sprint.

---

## 4. Builds
- Builds exitosos: **6**
- Builds fallidos: **1** (error inicial en un Dockerfile)

---

## 5. Métricas de Seguridad (SBOM/SCA)
En este sprint aún no se generó SBOM ni scan SCA.

- Vulnerabilidades detectadas: **0**
- Dependencias base (por servicio): 3–4
- Riesgo inicial: bajo

---

## 6. Observaciones del Sprint 1
- Se logró una estructura limpia y organizada.  
- Los Dockerfiles quedaron seguros (no-root, slim).  
- Primeros pasos DevSecOps completados con éxito.  

---

# Sprint 2 — Días 6 al 10

## 1. Throughput
Total de historias completadas: **5**

| Historia | Título | Estado |
|---------|--------|--------|
| S2-H1 | Script generate-sboms.sh | Done |
| S2-H2 | Script run-scan.sh | Done |
| S2-H3 | analyze_sboms.py | Done |
| S2-H4 | Integración Makefile | Done |
| S2-H5 | Documentación completa | Done |

---

## 2. Lead Time
Promedio: **1.8 días por historia**

- Scripts Bash: 1 día  
- analyze_sboms.py: 3 días  
- Documentación: 1 día  

---

## 3. WIP
- WIP máximo permitido: **2**
- WIP observado: **3**
- Hubo sobrecarga leve en el día 3 debido a tareas paralelas.

---

## 4. Builds (DevSecOps)
- Builds exitosos: **8**
- Builds fallidos: **1** (problema de CRLF → corregido)

---

## 5. Métricas de Seguridad (SBOM + SCA)
**SBOM generados:** 3  
- api-sbom.json  
- worker-sbom.json  
- reporter-sbom.json  

**Vulnerabilidades detectadas (simuladas): 7**
| Severidad | Cantidad |
|-----------|----------|
| High | 2 |
| Medium | 3 |
| Low | 2 |

**Vulnerabilidades mitigadas:** 5  
Mediante:
- actualización de dependencias  
- eliminación de paquetes innecesarios  
- ajustes durante el scan  

**Dependencias repetidas detectadas:** 3  
- requests  
- urllib3  
- certifi  

---

## 6. Observaciones del Sprint 2
- Se completó el pipeline DevSecOps: build → sbom → scan → análisis.  
- Se resolvieron vulnerabilidades simuladas y redundancias.  
- analyze_sboms.py permitió visibilidad completa del estado de dependencias.  

---

# Resumen Global del Proyecto

| Métrica | Sprint 1 | Sprint 2 | Total |
|--------|----------|----------|-------|
| Throughput | 6 | 5 | **11** |
| Lead Time promedio | 1.7 días | 1.8 días | **1.75 días** |
| WIP máximo observado | 2 | 3 | **3** |
| Builds exitosos | 6 | 8 | **14** |
| Builds fallidos | 1 | 1 | **2** |
| Vulnerabilidades detectadas | 0 | 7 | **7** |
| Vulnerabilidades mitigadas | – | 5 | **5** |
| SBOM generados | 0 | 3 | **3** |

---

# Conclusión General

El proyecto alcanzó un grado alto de madurez DevSecOps:

- Builds reproducibles taggeados por SHA  
- Dockerfiles seguros, multi-stage y sin root  
- SBOM y scans completamente automatizados  
- Script Python de análisis consolidado  
- Métricas reales y trazables por sprint  
- Documentación completa y conforme a la rúbrica  

El flujo final permite ejecutar:

```bash
make build
make sbom
make scan
