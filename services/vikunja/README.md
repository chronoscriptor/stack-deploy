# Vikunja — Task Management

## Access

| Detail | Value |
|---|---|
| Web URL | http://127.0.0.1:3456 |
| API | http://127.0.0.1:3456/api/v1 |
| Auth | JWT token via `POST /api/v1/login` |
| Version | v2.6.0 |

## Users

| Username | Role | Notes |
|---|---|---|
| `agent` | user | Primary agent account |
| Registration | Disabled after first user | Use `POST /api/v1/register` with token |

## API Reference

**Login:**
```bash
# Get JWT token
TOKEN=$(curl -s -X POST -H "Content-Type: application/json" \
  -d '{"username":"agent","password":"<pass>"}' \
  http://127.0.0.1:3456/api/v1/login | python3 -c "import sys,json; print(json.load(sys.stdin).get('token'))")
```

**Create project (uses PUT, not POST):**
```bash
curl -X PUT -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"title":"My Project"}' \
  http://127.0.0.1:3456/api/v1/projects
```

**Create task:**
```bash
curl -X PUT -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"title":"Task title","description":"Description"}' \
  http://127.0.0.1:3456/api/v1/projects/1/tasks
```

**List projects:**
```bash
curl -H "Authorization: Bearer $TOKEN" http://127.0.0.1:3456/api/v1/projects
```

**List tasks:**
```bash
curl -H "Authorization: Bearer $TOKEN" http://127.0.0.1:3456/api/v1/projects/1/tasks
```

## Architecture

- **Container:** `agent-default-vikunja`
- **Port:** `127.0.0.1:3456 -> 3456`
- **DB:** Postgres on `agent-shared-postgres` (database `agent_stack_vikunja`)
- **Redis:** `agent-shared-redis:6379` (queue/rate limiting)
- **Files:** `agent-default-vikunja-data` volume (attachments)
- **Network:** `agent-shared-net`

## Secrects
- `.env` (chmod 600) — DB password, JWT secret, registration token
