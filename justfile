# Agent Stack — quick commands

shared-up:
    docker compose -f shared/docker-compose.yml up -d

shared-down:
    docker compose -f shared/docker-compose.yml down

shared-logs:
    docker compose -f shared/docker-compose.yml logs -f

profile-up p:
    docker compose -f profiles/{{p}}/docker-compose.yml up -d

profile-down p:
    docker compose -f profiles/{{p}}/docker-compose.yml down

profile-logs p:
    docker compose -f profiles/{{p}}/docker-compose.yml logs -f

n8n-logs:
    docker logs agent-default-n8n -f

ps:
    docker ps --format 'table {{ '{{' }}.Names{{ '}}' }}\t{{ '{{' }}.Status{{ '}}' }}\t{{ '{{' }}.Ports{{ '}}' }}'

state:
    echo "=== Docker ===" && docker ps --format 'table {{ '{{' }}.Names{{ '}}' }}\t{{ '{{' }}.Status{{ '}}' }}\t{{ '{{' }}.Ports{{ '}}' }}'
    echo "=== Disk ===" && du -sh /home/steven/projects/agent-stack/

tree:
    find /home/steven/projects/agent-stack -maxdepth 4 -not -path '*/\.*' -not -path '*/node_modules/*' | head -60

# Future:
# morning-brief:   run morning brief workflow via n8n API
# evening-scribe:  run evening scribe workflow via n8n API
# analyze-week:    pi analyzes performance data and updates rules

# CRM
crm-up:
    docker compose -f profiles/default/services/crm/docker-compose.yml up -d

crm-down:
    docker compose -f profiles/default/services/crm/docker-compose.yml down

crm-logs:
    docker compose -f profiles/default/services/crm/docker-compose.yml logs -f

# Launch dedicated WordPress agent (pass mode, e.g. `just wp flash`)
wp mode="":
    @./scripts/run-wp.sh {{ if mode == "" { "" } else { mode } }}

# MCP Bridge
mcp-bridge-up:
    systemctl --user daemon-reload
    systemctl --user enable --now agent-mcp-bridge.service

mcp-bridge-down:
    systemctl --user stop agent-mcp-bridge.service

mcp-bridge-logs:
    journalctl --user -u agent-mcp-bridge.service -f

mcp-bridge-test:
    @echo 'Testing MCP bridge initialize...'
    @cd mcp-bridge && echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}' | timeout 3 node mcp-bridge.js
    @echo 'Testing tools/list...'
    @cd mcp-bridge && printf '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}\n{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}\n' | timeout 3 node mcp-bridge.js 2>/dev/null | head -5

# MCP Bridge
mcp-bridge-up:
    systemctl --user daemon-reload
    systemctl --user enable --now agent-mcp-bridge.service

mcp-bridge-down:
    systemctl --user stop agent-mcp-bridge.service

mcp-bridge-restart:
    systemctl --user restart agent-mcp-bridge.service

mcp-bridge-logs:
    journalctl --user -u agent-mcp-bridge.service -f --no-pager -n 50

mcp-bridge-test:
    @echo '=== Health ==='
    @curl -s http://127.0.0.1:8900/health
    @echo ''
    @echo '=== Tool count ==='
    @curl -s -X POST http://127.0.0.1:8900 -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' | node -pe "JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).result.tools.length"
    @echo '=== Quick check ==='
    @curl -s -X POST http://127.0.0.1:8900 -d '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"tasks.info","arguments":{}}}' | node -pe "'Vikunja: '+JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).result.version"
