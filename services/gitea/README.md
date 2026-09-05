# Gitea — Code Repositories

**Access:** http://127.0.0.1:3003  
**SSH:** ssh://localhost:3022  
**Container:** agent-default-gitea  
**Version:** latest (Go binary)

## Setup
First visit sets up admin account (email + password).  
Register as first user → becomes admin.

## Architecture
- **DB:** Postgres on `agent-shared-postgres` (agent_stack_gitea)
- **Ports:** 3003 (HTTP), 3022 (SSH)
- **Volumes:** gitea-data, gitea-repos
- **Network:** agent-shared-net
- **Offline mode:** enabled (no external fetch)

## API
REST API at http://127.0.0.1:3003/api/v1  
Auth via `Authorization: token <TOKEN>`

## Webhooks
Can push events to n8n webhooks when configured per-repo.
