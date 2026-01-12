
## What's included

- **Web Server**: Nginx on port `8080`
- **Databases**: 
  - PostgreSQL (custom) on port `5433`
  - MySQL on port `3306`
- **Monitoring**: Zabbix Server + Web UI on port `80`
- **Automation**: One-click deployment via `setup.sh`


### How to deploy
```bash
git clone -b experiments https://github.com/soadek/admin-practice-2026.git
cd admin-practice-2026
chmod +x setup.sh
./setup.sh

