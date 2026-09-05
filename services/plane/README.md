# Plane — Project Management

**Access:** http://127.0.0.1:8082 (Frontend)  
**API:** http://127.0.0.1:8081 (Backend)  
**Containers:** agent-default-plane-backend, agent-default-plane-frontend  
**License:** AGPLv3

## Setup
Use admin token from `.env` to create the first workspace/admin via API:
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <ADMIN_TOKEN>" \
  -d '{"email":"admin@ghoststack.local","password":"Admin2026!"}' \
  http://127.0.0.1:8081/api/users/
```

## Architecture
- **Backend:** Django on port 8081 (API + admin)
- **Frontend:** Next.js on port 8082 (UI)
- **DB:** Postgres on `agent-shared-postgres` (agent_stack_plane)
- **Redis:** agent-shared-redis:6379
- **Volume:** plane-data
- **Network:** agent-shared-net

## API
REST API at http://127.0.0.1:8081/api/  
Auth via JWT token from `POST /api/users/sign-in`
