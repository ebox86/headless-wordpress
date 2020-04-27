#!/usr/bin/env sh

set -e

if wp core is-installed
then
    echo "WordPress is already installed, exiting."
    exit
fi

wp core download --force

wp core install \
    --title="$WORDPRESS_TITLE" \
    --admin_user="$WORDPRESS_ADMIN_USER" \
    --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL" \
    --skip-email

wp option update blogdescription "$WORDPRESS_DESCRIPTION"
wp rewrite structure "$WORDPRESS_PERMALINK_STRUCTURE"

wp plugin delete akismet hello
wp plugin install --activate --force \
    acf-to-wp-api \
    advanced-custom-fields \
    custom-post-type-ui \
    amazon-s3-and-cloudfront \
    wordpress-importer \
    wp-rest-api-v2-menus \
    jwt-authentication-for-wp-rest-api \
    https://github.com/wp-graphql/wp-graphql/archive/v0.8.3.zip \
    https://github.com/wp-graphql/wp-graphql-jwt-authentication/archive/V0.4.0.zip \
    /var/www/plugins/*.zip

echo "wordpress setup complete!"
