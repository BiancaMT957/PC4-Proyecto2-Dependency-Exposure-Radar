# Variables de entorno
API_IMAGE=auditor-api:0.1
WORKER_IMAGE=auditor-worker:0.1
REPORTER_IMAGE=auditor-reporter:0.1

.PHONY: build-api build-worker build-reporter build-all \
        run-api run-worker run-reporter run-all \
        clean-images clean

# Contructores
build-api:
	docker build -t $(API_IMAGE) services/api

build-worker:
	docker build -t $(WORKER_IMAGE) services/worker

build-reporter:
	docker build -t $(REPORTER_IMAGE) services/reporter

build-all: build-api build-worker build-reporter


# Ejecutables
run-api:
	docker run --rm -p 8080:8080 $(API_IMAGE)

run-worker:
	docker run --rm $(WORKER_IMAGE)

run-reporter:
	docker run --rm $(REPORTER_IMAGE)

run-all:
	docker-compose up

clean-images:
	docker rmi $(API_IMAGE) $(WORKER_IMAGE) $(REPORTER_IMAGE) || true

clean:
	docker system prune -f

help:
	@echo "Comandos disponibles:"
	@echo ""
	@echo "  build-api        Construye la imagen Docker del servicio API"
	@echo "  build-worker     Construye la imagen Docker del Worker"
	@echo "  build-reporter   Construye la imagen Docker del Reporter"
	@echo "  build-all        Construye todas las imágenes"
	@echo ""
	@echo "  run-api          Ejecuta la API en el puerto 8080"
	@echo "  run-worker       Ejecuta el Worker"
	@echo "  run-reporter     Ejecuta el Reporter"
	@echo "  run-all          Levanta todos los servicios con docker-compose"
	@echo ""
	@echo "  clean-images     Elimina imágenes construidas"
	@echo "  clean            Limpia recursos Docker no utilizados"
	@echo ""