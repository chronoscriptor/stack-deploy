# Baserow — Structured Data (No-code Database)

**Access:** http://127.0.0.1:3004  
**Container:** agent-default-baserow  
**Version:** latest (Postgres-backed)

## Setup
First visit → create admin account.  
Create databases/tables via drag-and-drop UI or REST API.

## Architecture
- **DB:** Postgres on `agent-shared-postgres` (agent_stack_baserow)
- **Port:** 3004
- **Redis:** agent-shared-redis:6379
- **Volume:** baserow-data
- **Network:** agent-shared-net

## API
REST API at http://127.0.0.1:3004/api/  
Auth via JWT token from `POST /api/user/token-auth/`

Auto-generated REST endpoints for every table you create.

## n8n Integration
Baserow has auto REST APIs per table. n8n's HTTP Request node works directly.
