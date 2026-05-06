SHELL := /bin/sh

PROJECT_NAME := codequest
FLUTTER_DEFINE_DEV := --dart-define=USE_EMULATOR=true

.PHONY: help up bootstrap infra-up infra-down clean logs seed deps gen analyze test build-apk run migrate ci doctor

help:
	@echo "Comandos disponíveis:"
	@echo "  make up        - Sobe docker, aplica bootstrap e inicia o app Flutter"
	@echo "  make bootstrap - Instala deps e gera código"
	@echo "  make infra-up  - Sobe emuladores e seed"
	@echo "  make infra-down- Derruba emuladores"
	@echo "  make run       - Roda o app Flutter em modo dev"
	@echo "  make ci        - Executa pipeline local (analyze/test/build)"

up: infra-up deps migrate gen run

bootstrap: deps migrate gen

infra-up:
	docker compose up -d --build

infra-down:
	docker compose down

clean:
	flutter clean
	docker compose down -v

logs:
	docker compose logs -f firebase-emulators

seed:
	docker compose run --rm seed-runner

deps:
	flutter pub get
	npm --prefix firebase/functions install
	npm --prefix firebase/seed install

migrate:
	@echo "Firestore é schemaless; índices e regras são aplicados pelos emuladores via firebase/firebase.json"

gen:
	dart run build_runner build --delete-conflicting-outputs

analyze:
	flutter analyze

test:
	flutter test

build-apk:
	flutter build apk --release

run:
	flutter run $(FLUTTER_DEFINE_DEV)

ci: deps gen analyze test

doctor:
	flutter doctor -v
	docker --version
	docker compose version
