#!/bin/bash
set -e

sudo apt update

echo "Installing Docker..."
sudo apt install -y docker.io docker-compose-v2
sudo usermod -aG docker $USER
sudo systemctl enable --now docker

echo "Installing Zabbix Agent..."
wget -q https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_7.0-1+ubuntu24.04_all.deb
sudo apt update
sudo apt install -y zabbix-agent

echo " Configuring Zabbix Agent..."
sudo sed -i "s/^Server=.*/Server=0.0.0.0\/0/" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/^#* ServerActive=.*/ServerActive=127.0.0.1/" /etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/^#* Hostname=.*/Hostname=MyUbuntuHost/" /etc/zabbix/zabbix_agentd.conf
sudo systemctl enable --now zabbix-agent

echo " Starting Docker services..."
cd "$(dirname "$0")"  # перейти в папку, где лежит скрипт
docker compose -f docker-compose-full.yml up -d

IP=$(hostname -I | awk '{print $1}')
echo ""
echo "DONE! Your infrastructure is ready."
echo "Zabbix: http://$IP"
echo "Nginx:  http://$IP:8080"
echo "PostgreSQL (custom): port 5433"
echo "MySQL: port 3306"
