# CodeQuest - Infraestrutura Local

Este repositório contém o setup inicial do CodeQuest para desenvolvimento mobile com Flutter + Firebase Emulator Suite.
O objetivo deste estágio é garantir ambiente funcional local, base arquitetural e fluxo de desenvolvimento padronizado.

## O que já está pronto

- Infra local com Docker Compose para emuladores Firebase
- Seed inicial de usuários, liga, trilha e atividades
- Bootstrap Flutter com Firebase, Hive, Riverpod e GoRouter
- Estrutura base de autenticação (login/cadastro/sessão)
- Configurações de VS Code e CI no GitHub Actions
- Documentação de arquitetura e diretrizes de engenharia

## Pré-requisitos

- Docker Desktop com WSL2 habilitado (Windows)
- Flutter SDK instalado na máquina host
- Android Studio com AVD configurado
- make instalado no ambiente (ou usar Git Bash com make)

Versões recomendadas:

- Flutter stable 3.24+
- Dart 3.5+
- Node.js 18+
- Docker Compose v2+

## Primeiros passos (novo desenvolvedor)

1. Clonar o repositório.
2. Entrar na pasta do projeto.
3. Rodar o setup completo com make up.

Fluxo sugerido:

```bash
git clone <url-do-repositorio>
cd codequest
make up
```

Se não tiver make no Windows, execute manualmente:

```bash
docker compose up -d --build
flutter pub get
npm --prefix firebase/functions install
npm --prefix firebase/seed install
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define=USE_EMULATOR=true
```

## Subir ambiente local

```bash
make up
```

Comportamento do make up:

1. Sobe emuladores Firebase + seed via Docker Compose.
2. Instala dependências Flutter e Node (functions/seed).
3. Executa geração de código com build_runner.
4. Inicia o app Flutter com USE_EMULATOR=true.

Serviços disponíveis:

- Firebase Emulator UI: http://localhost:4000
- Firestore Emulator: localhost:8080
- Auth Emulator: localhost:9099
- Functions Emulator: localhost:5001
- FCM Emulator: localhost:9150

## Diferença entre make up e make infra-up

- make infra-up: sobe apenas Docker e seed da infraestrutura.
- make up: sobe infraestrutura + instala dependências + gera código + inicia o app Flutter.

## Comandos úteis

```bash
make infra-up
make infra-down
make bootstrap
make analyze
make test
make ci
make logs
make doctor
make clean
```

## Usuários seed

- dev@codequest.com / Dev@123456
- alice@codequest.com / Dev@123456
- bob@codequest.com / Dev@123456
- admin@codequest.com / Dev@123456

## Dev vs Produção

- Desenvolvimento local: usar USE_EMULATOR=true
- Produção: USE_EMULATOR=false

Configuração de debug no VS Code:

- CodeQuest DEV: usa USE_EMULATOR=true
- CodeQuest PROD: usa USE_EMULATOR=false

## Estrutura de pastas (resumo)

```text
codequest/
  firebase/
    functions/            # Cloud Functions
    seed/                 # Seed inicial para emuladores
  lib/
    core/                 # Firebase, rotas e tema
    features/             # Módulos por funcionalidade
    shared/               # Widgets e temas compartilhados
  docs/                   # Arquitetura e padrões de desenvolvimento
  .vscode/                # Setup de editor e debug
  .github/workflows/      # CI/CD
```

## Documentação do projeto

- docs/ARCHITECTURE.md
- docs/ENGINEERING_GUIDELINES.md
- docs/BUSINESS_CORE_AUTH.md
- docs/MODULE_BASE_BLUEPRINT.md
- docs/PENDENCIAS_PROMPT.md
- AGENTS.md

## Configuração de ambiente

- Copie .env.example para .env quando precisar configurar variáveis locais adicionais.

## Diagramas Mermaid

- O diagrama de infraestrutura está em docs/ARCHITECTURE.md.
- Para editar e visualizar Mermaid no VS Code, instale as extensões recomendadas do workspace.
- Padrão adotado: usar blocos mermaid em markdown para manter diagramas versionados junto do código.

## Credenciais seed

- dev@codequest.com / Dev@123456
- alice@codequest.com / Dev@123456
- bob@codequest.com / Dev@123456
- admin@codequest.com / Dev@123456

## Troubleshooting rápido

- App Android não conecta no Firebase:
  - confirmar Docker ativo com docker ps
  - confirmar uso de host 10.0.2.2 no emulador Android
- Porta ocupada:
  - ajustar docker-compose.yml e lib/core/firebase_config.dart
- Seed não subiu:
  - verificar logs com docker compose logs seed-runner
- Erro em código gerado:
  - rodar dart run build_runner build --delete-conflicting-outputs

