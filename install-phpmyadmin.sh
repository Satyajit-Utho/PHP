#!/bin/bash

set -e

echo "🚀 Updating packages..."
apt update && apt upgrade -y

echo "🌐 Installing Apache2..."
apt install apache2 -y
systemctl enable apache2
systemctl start apache2

echo "📦 Installing PHP and required extensions..."
apt install php php-mbstring php-zip php-gd php-json php-curl php-mysql php-cli libapache2-mod-php unzip -y

echo "🛠️ Installing phpMyAdmin..."
export DEBIAN_FRONTEND=noninteractive
apt install phpmyadmin -y

echo "🔗 Enabling phpMyAdmin Apache config..."
ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
a2enconf phpmyadmin
systemctl reload apache2

echo "🌐 Opening firewall ports..."
ufw allow 'Apache Full' || true

echo "✅ Installation complete!"
echo "🌐 Access phpMyAdmin at: http://$(curl -s ifconfig.me)/phpmyadmin"
