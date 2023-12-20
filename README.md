# Ruby on Rails with prometheus/grafana/loki for monitoring

This is a template to create a rails project with prom and grafana monitiring from start.

- This project requires docker.

### Contents
- Minimal Rails app
- Prometheus
- Grafana
- Loki
- Promtail
- Caddy
- Redis
- Postgres

### Running
- check the .env and compose files to change secrets
- change compose files latest versions to avoid breaking changes whant using it as a template
- run `docker compose -f docker-compose.yaml -f docker-compose.dev.yaml up -d --build`
- access grafana panel
- add loki and prometheus as connections
- access rails app to generate logs
- add grafana dash with loki metrics 
