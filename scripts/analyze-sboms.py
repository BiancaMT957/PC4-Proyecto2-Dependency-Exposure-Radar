#!/usr/bin/env python3
import json
import os
from pathlib import Path

def load_sboms(sbom_dir: Path):
    """Carga todos los archivos JSON dentro de sbom_dir."""
    sboms = []
    for file in sbom_dir.glob("*.json"):
        try:
            with open(file, "r", encoding="utf-8") as f:
                data = json.load(f)
                sboms.append({"file": file.name, "data": data})
        except json.JSONDecodeError:
            print(f"⚠ Error: {file} no es JSON válido. Se ignora.")
    return sboms


def extract_dependencies(sbom_data):
    """
    Extrae dependencias o vulnerabilidades según el formato.
    Como los SBOM pueden ser reales o simulados, se manejan ambos casos:
      - SBOM simulado: 'vulnerabilities': [ {package...} ]
      - SBOM con formato CycloneDX o Syft/Grype puede tener 'packages'
    """
    deps = []

    # Caso SBOM simulado
    if "vulnerabilities" in sbom_data:
        for v in sbom_data["vulnerabilities"]:
            deps.append(v.get("package", "unknown"))

    # Caso SBOM real (CycloneDX / Syft)
    if "packages" in sbom_data:
        for p in sbom_data["packages"]:
            deps.append(p.get("name", "unknown"))

    return deps


def analyze(sboms):
    all_dependencies = []
    for sbom in sboms:
        deps = extract_dependencies(sbom["data"])
        for d in deps:
            all_dependencies.append(d)

    # Detectar repetidos
    counts = {}
    for dep in all_dependencies:
        counts[dep] = counts.get(dep, 0) + 1

    repeated = {k: v for k, v in counts.items() if v > 1}

    return {
        "total_sboms": len(sboms),
        "total_dependencies": len(all_dependencies),
        "repeated_dependencies": repeated,
    }


def main():
    ROOT = Path(__file__).resolve().parent.parent
    SBOMS_DIR = ROOT / "sboms"
    REPORTS_DIR = ROOT / "reports"
    REPORTS_DIR.mkdir(exist_ok=True)

    print("🔍 Analizando SBOMs...")
    sboms = load_sboms(SBOMS_DIR)

    if not sboms:
        print("No se encontraron SBOMs. Finalizando.")
        return

    result = analyze(sboms)

    output_file = REPORTS_DIR / "report.json"
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2)

    print(f"Análisis completado. Reporte generado en: {output_file}")


if __name__ == "__main__":
    main()