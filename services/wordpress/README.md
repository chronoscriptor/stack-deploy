# WordPress — Landing Page & Blog

| Field | Value |
|---|---|
| Port | `127.0.0.1:8088` |
| Access | `www.chronoscriptor.com` (via tunnel) or `localhost:8088` |
| DB | MariaDB 11.4, volume `agent-wordpress-db` |
| Uploads | Volume `agent-wordpress` (`/var/www/html`) |
| Network | `agent-shared-net` (external) |

## First login
1. Open http://localhost:8088
2. Complete the WordPress setup wizard
3. Install an SEO plugin (Yoast or RankMath)
4. Choose a lightweight theme

## SEO plugins
- Yoast SEO (free)
- RankMath SEO (free)
- Both handle sitemaps, meta, Open Graph

## Quick commands
```bash
# Start
docker compose -f services/wordpress/docker-compose.yml up -d

# Logs
docker compose -f services/wordpress/docker-compose.yml logs -f

# Stop
docker compose -f services/wordpress/docker-compose.yml down
```
