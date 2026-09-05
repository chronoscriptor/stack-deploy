# Chronoscriptor Stack Deploy

> One-command deployment of a complete self-hosted agent stack.

## What you get

| Service | Port | Purpose |
|---|---|---|
| **n8n** | `:5678` | Workflow engine (spine) |
| **EspoCRM** | `:3001` | Contacts, accounts, deals |
| **Vikunja** | `:3456` | Tasks, todos |
| **Mattermost** | `:8065` | Team chat, bot APIs |
| **Gitea** | `:3003` (HTTP), `:3022` (SSH) | Code repos, webhooks |
| **Wiki.js** | `:3002` | Knowledge base |
| **Plane** | `:8081` (BE), `:8082` (FE) | Project management |
| **Baserow** | `:3004` | Structured data |
| **Whisper.cpp** | `:8866` | Speech-to-text |
| **WordPress** | `:8088` | Web publishing |

All behind `agent-shared-net` (bridge), all bound to `127.0.0.1`.

## Quick Start

```bash
# 1. Clone
git clone git@codeberg.org:chronoscriptor/stack-deploy.git
cd stack-deploy

# 2. Configure
cp .env.example .env
# Edit .env with your passwords (generate secure random values)
nano .env

# 3. Start shared infra (Postgres + Redis)
just shared-up

# 4. Start individual services
just crm-up     # EspoCRM
just vikunja-up
just mattermost-up
just gitea-up
just wiki-up
just plane-up
just baserow-up
just whisper-up
just wordpress-up

# Or start the whole default profile
just profile-up default
```

## Architecture

```
┌────────────────────────────────────────────────────┐
│                  SHARED INFRASTRUCTURE              │
│  Postgres 16 (:5432) · Redis 7 (:6379)            │
│  Network: agent-shared-net (bridge)                │
└────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────┐
│                  SERVICES                          │
│  :5678  n8n          (workflow engine)             │
│  :3001  EspoCRM      (CRM)                         │
│  :3456  Vikunja      (tasks)                       │
│  :8065  Mattermost   (chat)                        │
│  :3003  Gitea        (code)                        │
│  :3002  Wiki.js      (knowledge)                   │
│  :8081  Plane        (projects)                    │
│  :3004  Baserow      (data)                        │
│  :8866  Whisper.cpp  (transcription)               │
│  :8088  WordPress    (web)                         │
└────────────────────────────────────────────────────┘
```

## Commands

```bash
just ps           # View all running services
just shared-up    # Start Postgres + Redis
just shared-down  # Stop shared infra
just crm-up       # Start individual service
just crm-down     # Stop individual service
just crm-logs     # Tail logs for a service
just profile-up default  # Start entire default profile
```

## Requirements

- Docker + Docker Compose v2
- ~4 GB RAM for all services
- Linux (tested on Ubuntu 24.04)
- Ports 3001-8088, 5678, 8866, 3022 available on localhost

## MCP Integration

Pair with the [mcp-bridge](https://codeberg.org/chronoscriptor/mcp-bridge) to expose all services as discoverable MCP tools from a single pi agent session.

## License

AGPL-3.0 (service images carry their own licenses; glue code is MIT)