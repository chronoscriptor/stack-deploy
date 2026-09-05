# Agent Stack — System Fingerprint

> One-glance overview of the entire architecture. Every service, port, path, and connection point.
> Updated: 2026-09-02 after batch deployment of 9 services.

## Infrastructure Layer

```
┌──────────────────────────────────────────────────────────┐
│                     SHARED INFRASTRUCTURE                 │
│                    agent-stack/shared/                    │
│                                                          │
│  Postgres 16 (:5432)  ← agent-shared-postgres            │
│  Redis 7   (:6379)    ← agent-shared-redis               │
│                                                          │
│  Network: agent-shared-net (bridge)                      │
│  Volumes: agent-shared-postgres, agent-shared-redis      │
└──────────────────────────────────────────────────────────┘
```

## Default Profile — 9 Services

```
┌────────────────────────────────────────────────────────────┐
│                    DEFAULT PROFILE                          │
│                                                             │
│  :5678  n8n         (workflow engine, spine of the system) │
│  :3001  EspoCRM     (contacts, accounts, deals)            │
│  :3456  Vikunja     (tasks, todos)                         │
│  :8065  Mattermost  (team chat, bot APIs)                  │
│  :3003  Gitea       (code repos, webhooks)                 │
│  :3002  Wiki.js     (knowledge base, GraphQL)              │
│  :8081  Plane BE    (project management backend)           │
│  :8082  Plane FE    (project management frontend)          │
│  :3004  Baserow     (no-code database, REST APIs)          │
│  :8866  Whisper.cpp (speech-to-text)                       │
│                                                             │
│  Volumes: 8 named volumes across all services              │
│  Network: agent-shared-net (external bridge)               │
│  Memory:  512m–2g per service                              │
└────────────────────────────────────────────────────────────┘
```

## Port Map (default profile)

| Port | Service | Container | Internal port |
|---|---|---|---|
| 3001 | EspoCRM | agent-default-crm | :80 |
| 3002 | Wiki.js | agent-default-wiki | :3000 |
| 3003 | Gitea HTTP | agent-default-gitea | :3000 |
| 3022 | Gitea SSH | agent-default-gitea | :22 |
| 3004 | Baserow | agent-default-baserow | :3000 |
| 3456 | Vikunja | agent-default-vikunja | :3456 |
| 5678 | n8n | agent-default-n8n (no compose) | :5678 |
| 8065 | Mattermost | agent-default-mattermost | :8065 |
| 8081 | Plane Backend | agent-default-plane-backend | :8000 |
| 8082 | Plane Frontend | agent-default-plane-frontend | :3000 |
| 8866 | Whisper.cpp | agent-default-whisper | :9000 |

## Volume Map

| Volume | Content | Service |
|---|---|---|
| agent-shared-postgres | All structured data | Postgres |
| agent-shared-redis | Cache, queues | Redis |
| agent-default-n8n | n8n config + credentials | n8n |
| agent-default-crm-data | EspoCRM files | EspoCRM |
| agent-default-crm-db-data | EspoCRM database | MariaDB |
| agent-default-vikunja-data | Vikunja attachments | Vikunja |
| agent-default-whisper-models | Whisper model files | Whisper |
| agent-default-mattermost-* (3x) | Config, data, logs | Mattermost |
| agent-default-gitea-* (2x) | Data, repos | Gitea |
| agent-default-wiki-data | Wiki uploads | Wiki.js |
| agent-default-plane-data | Plane assets | Plane |
| agent-default-baserow-data | Baserow data | Baserow |

## Data Flow

```
pi (Deepseek V4 Flash)
  │
  │ REST / Webhook
  ▼
n8n ──┬── Schedule (Morning Brief, weekdays 8 AM)
      ├── Webhook (EspoCRM test endpoint)
      └── [future] Google APIs, Cal.com, Proton
           │
           ▼
     ┌────┴────┬───────┬──────┬───────┬──────┐
     ▼         ▼       ▼      ▼       ▼      ▼
  EspoCRM  Vikunja  Gitea  Wiki.js  Plane  Baserow
  (CRM)    (tasks)  (code) (docs)   (proj) (data)
     │         │
     └──┬──────┘
        ▼
   Mattermost
   (alerts, briefs)
```

## n8n Workflow Registry

See `profiles/default/config/workflows/_index.md` for full registry.
2 workflows active:
1. **EspoCRM Integration Test** — Webhook → Create Account
2. **Morning Brief** — Schedule → Vikunja + EspoCRM → Merge → Brief

## Front-End Integration

| Service | Agent account | Status |
|---|---|---|
| Gmail | 🔲 Not created | Next step |
| Google Calendar | 🔲 Not created | Next step |
| Proton Mail | 🔲 Not created | Next step |
| Cal.com | 🔲 Not created | Next step |

## Security Posture

| Item | Setting |
|---|---|
| Docker network | Bridge only — no host networking |
| Port exposure | `127.0.0.1` only — no LAN/WAN |
| Secrets | `.env` files, chmod 600, never committed |
| Service READMEs | Each has README.md (.public) + CREDENTIALS.md (chmod 600) |
| AI agent | Deepseek V4 Flash via pi — local-first |
| Encryption | n8n encryption key, per-service JWT secrets |
| Network isolation | Each service on `agent-shared-net`, not host |

## Key Files

| File | Content |
|---|---|
| `AGENTS.md` | Boot anchor — read by pi every session |
| `profiles/_index.md` | Profile registry + PDR build phases |
| `FINGERPRINT.md` | This file — one-glance architecture |
| `docs/PDR-ai-executive-system.md` | Full 18-phase reference document |
| `profiles/default/secrets/credentials.md` | Master credentials (chmod 600) |
| `profiles/default/config/workflows/_index.md` | All n8n workflows deployed |
