# Mattermost — Team Chat

**Access:** http://127.0.0.1:8065  
**Container:** agent-default-mattermost  
**Version:** Team Edition (latest)

## Setup
First visit will prompt to create the System Admin account.

## Architecture
- **DB:** Postgres on `agent-shared-postgres` (agent_stack_mattermost)
- **Port:** 127.0.0.1:8065
- **Volumes:** config, data, logs
- **Network:** agent-shared-net

## API Access
REST API at http://127.0.0.1:8065/api/v4  
Auth via Bearer token from `POST /api/v4/users/login`

## Bot Setup
Create a bot account from: System Console → Integrations → Bot Accounts
