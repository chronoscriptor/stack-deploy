# Chronoscriptor Stack Deploy

One-command deployment of a complete self-hosted agent stack — 10 services, shared infrastructure, and MCP bridge integration.

## Services

| Service | Port | Purpose | OSS | Image |
|---|---|---|---|---|
| n8n | `:5678` | Workflow engine (spine) | ✅ Sustainable Use | n8nio/n8n |
| EspoCRM | `:3001` | CRM (contacts, accounts, deals) | ✅ AGPL | espocrm/espocrm |
| Vikunja | `:3456` | Task management | ✅ GPL | vikunja/vikunja |
| Mattermost | `:8065` | Team chat | ✅ MIT | mattermost/mattermost-team-edition |
| Gitea | `:3003` / `:3022` | Code repos | ✅ MIT | gitea/gitea |
| Wiki.js | `:3002` | Knowledge base | ✅ AGPL | requarks/wiki |
| Plane | `:8081` / `:8082` | Project management | ✅ AGPL | makeplane/plane |
| Baserow | `:3004` | Structured data | ✅ MIT | baserow/baserow |
| Whisper.cpp | `:8866` | Speech-to-text | ✅ MIT | onerahmet/openai-whisper-asr-webservice |
| WordPress | `:8088` | Web publishing | ✅ GPL | wordpress |

## Quick Start

```bash
git clone git@codeberg.org:chronoscriptor/stack-deploy.git
cd stack-deploy
cp .env.example .env
# Edit .env with secure passwords
just shared-up       # Start Postgres + Redis
just profile-up default  # Start all services
```

## Requirements

- Docker + Docker Compose v2
- 4 GB RAM minimum
- Linux (tested on Ubuntu 24.04)

## Architecture

```
┌──────────────────────────────────────────────────┐
│                 SHARED INFRASTRUCTURE             │
│   Postgres 16 (:5432) ← agent-shared-postgres    │
│   Redis 7   (:6379)   ← agent-shared-redis       │
│   Network: agent-shared-net (bridge)              │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│                   SERVICES (default profile)      │
│   :5678  n8n          (automation)                │
│   :3001  EspoCRM      (crm)                       │
│   :3456  Vikunja      (tasks)                     │
│   :8065  Mattermost   (chat)                      │
│   :3003  Gitea        (code)                      │
│   :3002  Wiki.js      (knowledge)                 │
│   :8081  Plane        (projects)                  │
│   :3004  Baserow      (data)                      │
│   :8866  Whisper.cpp  (transcription)             │
│   :8088  WordPress    (web)                       │
└──────────────────────────────────────────────────┘
```

## MCP Integration

With the [mcp-bridge](https://codeberg.org/chronoscriptor/mcp-bridge), a single pi agent session discovers all 10 services as MCP tools:

```bash
just mcp-bridge-up    # Start bridge on :8900
# Then from pi: /bridge to see all tools
```

## License

The compose files and orchestration code are MIT. Individual service images carry their own licenses (AGPL, GPL, MIT as noted above).