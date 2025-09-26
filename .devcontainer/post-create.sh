#!/usr/bin/env bash
set -e

cd /workspaces/${PWD##*/}
composer install || true
npm install || true

# Install WordPress if not already installed
if ! wp core is-installed --path=wordpress --allow-root 2>/dev/null; then
  wp core download --path=wordpress --allow-root
  wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost=db --path=wordpress --allow-root
  WP_URL="http://localhost:8080"
  wp core install --url="$WP_URL" --title="WP Codespace" --admin_user=admin --admin_password=admin --admin_email=dev@example.com --path=wordpress --allow-root
fi
