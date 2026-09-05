# Wiki.js — Knowledge Base

**Access:** http://127.0.0.1:3002  
**Container:** agent-default-wiki  
**Version:** latest (Node.js)

## Setup
First visit prompts for admin account creation.  
Wiki.js supports Markdown, GraphQL, and multiple auth strategies.

## Architecture
- **DB:** Postgres on `agent-shared-postgres` (agent_stack_wiki)
- **Port:** 3002
- **Volume:** wiki-data (uploads/attachments)
- **Network:** agent-shared-net

## GraphQL API
Wiki.js has a powerful GraphQL API at `/graphql`.  
Auth via `Authorization: Bearer <API_KEY>` (generate from admin panel).

## n8n Integration
Wiki.js can trigger webhooks on page changes, or n8n can query the GraphQL API.
