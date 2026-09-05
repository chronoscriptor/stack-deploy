# Profiles Registry

Every profile is an independent identity with its own services, config, and purpose.
They share the same infrastructure (Postgres, Redis) but have isolated n8n instances.

## Fingerprint Chart

Quick-reference matrix of every profile — its identity, services, ports, and connection points.

| # | Profile | Purpose | n8n | CRM | Tasks | Chat | Code | Wiki | Projects | Data | Transcribe | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | `default` | Primary identity | `:5678` | `:3001` | `:3456` | `:8065` | `:3003` | `:3002` | `:8081` | `:3004` | `:8866` | ✅ Active |
| — | `———` | — | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | ⏳ |
| — | `———` | — | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | ⏳ |
| — | `———` | — | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | `:—` | ⏳ |

**Reserved port ranges** (profiles 1–4 on localhost, no LAN exposure):

| Service | Default | Profile 2 | Profile 3 | Profile 4 |
|---|---|---|---|---|
| n8n | `:5678` | `:5680` | `:5681` | `:5682` |
| EspoCRM | `:3001` | `:3002` | `:3003` | `:3004` |
| Vikunja | `:3456` | `:3457` | `:3458` | `:3459` |
| Mattermost | `:8065` | `:8066` | `:8067` | `:8068` |
| Gitea | `:3003` | `:3013` | `:3023` | `:3033` |
| Wiki.js | `:3002` | `:3012` | `:3022` | `:3032` |
| Plane BE | `:8081` | `:8083` | `:8085` | `:8087` |
| Plane FE | `:8082` | `:8084` | `:8086` | `:8088` |
| Baserow | `:3004` | `:3014` | `:3024` | `:3034` |
| Whisper | `:8866` | `:8867` | `:8868` | `:8869` |

---

## Active Profile: `default`

| Detail | Value |
|---|---|
| n8n | `127.0.0.1:5678` |
| EspoCRM | `127.0.0.1:3001` |
| Vikunja | `127.0.0.1:3456` |
| Mattermost | `127.0.0.1:8065` |
| Gitea | `127.0.0.1:3003` (HTTP), `:3022` (SSH) |
| Wiki.js | `127.0.0.1:3002` |
| Plane | `127.0.0.1:8081` (BE), `:8082` (FE) |
| Baserow | `127.0.0.1:3004` |
| Whisper | `127.0.0.1:8866` |
| Agent accounts | 🔲 Not yet created (planned) |
| Workflows | 2 active (see `config/workflows/_index.md`) |

---

## PDR Build Phases — Progress

### Phase 1 — Foundation ✅
- [x] Define "How to Work With Me" → `config/constitution/`
- [x] Define "Definition of Winning" → `config/constitution/`
- [x] Choose primary AI agent → pi + Deepseek V4 Flash
- [x] Deploy shared infra (Postgres, Redis)
- [x] Deploy all 9 services (n8n, EspoCRM, Vikunja, Mattermost, Whisper, Gitea, Wiki.js, Plane, Baserow)

### Phase 2 — Personal Executive Assistant 🟡 In Progress
- [x] Morning Brief — n8n workflow (weekdays 8 AM, active)
- [ ] Evening Scribe — planned (needs agent accounts for email/calendar)
- [ ] Performance Dataset — Baserow ready, not yet populated
- [ ] Pattern Detection — pi analysis, not yet configured

### Phase 3 — Decision Intelligence ⏳
- [ ] Argue Back Layer
- [ ] War Council
- [ ] Decision Protocol

### Phase 4 — Business Intelligence 🟡 In Progress
- [x] EspoCRM deployed and wired to n8n
- [ ] Weekly Customer Brief — planned
- [ ] Automated account intelligence — planned

### Phase 5 — Agentic Operations ⏳
- [ ] Reusable AI skills
- [ ] Deterministic workflows
- [ ] Error recovery layer
- [ ] Cloudflare Tunnel

### Phase 6 — Continuous Learning ⏳
- [ ] Pattern detection → operational rules
- [ ] Periodic audit
- [ ] Workflow improvement loop

---

## Adding a New Profile

See `PROFILE_NEW.md` for the full procedure. Key checklist:
1. Copy `profiles/default/` to `profiles/<name>/`
2. Change ALL secrets in `.env`
3. Change ALL ports (use reserved range above)
4. Change ALL container names and volume names
5. Deploy: `docker compose -f profiles/<name>/docker-compose.yml up -d`
6. Register in this index + FINGERPRINT.md

