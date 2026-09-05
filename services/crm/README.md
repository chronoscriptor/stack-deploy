# EspoCRM — CRM Service

## Access

| Detail | Value |
|---|---|
| Web URL | http://127.0.0.1:3001 |
| Admin user | `admin` |
| Admin password | Stored in `.env` (chmod 600) |
| API user | `api-agent` (type: api) |
| API key | `35a608cd4f163e9a85cfa1d6604f3c6e` |
| API key auth | Header `X-Api-Key: <key>` |
| DB | MariaDB 10.11 (internal, port 3306) |
| Network | `agent-shared-net` + connected to `n8n_n8n-net` |
| Version | EspoCRM 10.0.6 |

## API Authentication

EspoCRM 10.x uses **HTTP Basic Auth** per-request. There is no `/api/v1/login` endpoint.

**As admin user:**
```bash
curl -u "admin:<password>" http://127.0.0.1:3001/api/v1/Account
```

**As API user (recommended for agents):**
```bash
curl -H "X-Api-Key: 35a608cd4f163e9a85cfa1d6604f3c6e" http://127.0.0.1:3001/api/v1/Account
```

### API users
| Username | Type | Role | Notes |
|---|---|---|---|
| `admin` | admin | (built-in) | Full access |
| `steven` | admin | — | Template human profile |
| `api-agent` | api | API Full Access | Used by n8n |

## n8n Integration

### Credential
- **Name:** EspoCRM Agent Access
- **Type:** espoCRMApi
- **URL:** `http://agent-default-crm:80` (Docker internal)
- **API Key:** `35a608cd4f163e9a85cfa1d6604f3c6e`

### Test Workflow
- **Name:** EspoCRM Test - Create Account
- **Trigger:** Webhook `POST /webhook/espocrm-test-webhook`
- **Flow:** Webhook → EspoCRM Create Account → Respond
- **Status:** ✅ Active and verified

```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"name":"Test Account"}' \
  http://127.0.0.1:5678/webhook/espocrm-test-webhook
```

## Volumes
- `agent-default-crm-data` — EspoCRM data
- `agent-default-crm-custom` — Custom files
- `agent-default-crm-client-custom` — Custom client files
- `agent-default-crm-db-data` — MariaDB data

## Secrets
- `.env` (chmod 600) — DB + admin credentials
- `.env.template` — Placeholder template

## Network
- Container is dual-homed: `agent-shared-net` + `n8n_n8n-net`
- n8n reaches it as `agent-default-crm:80`
