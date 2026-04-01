#!/usr/bin/env bash
# Creates per-service databases inside the single FlowCore PostgreSQL instance.
# Add new databases here as new services are introduced.
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE keycloak;
    CREATE DATABASE platform_service;
    CREATE DATABASE tenant_service;
    CREATE DATABASE notification_service;

    GRANT ALL PRIVILEGES ON DATABASE keycloak             TO $POSTGRES_USER;
    GRANT ALL PRIVILEGES ON DATABASE platform_service     TO $POSTGRES_USER;
    GRANT ALL PRIVILEGES ON DATABASE tenant_service       TO $POSTGRES_USER;
    GRANT ALL PRIVILEGES ON DATABASE notification_service TO $POSTGRES_USER;
EOSQL

echo "FlowCore databases initialised."
