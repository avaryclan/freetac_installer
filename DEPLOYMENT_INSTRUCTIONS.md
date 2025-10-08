# FreeTAK Server Deployment Instructions

## Overview
This document provides instructions for successfully deploying the FreeTAK Server using Docker containers.

## Prerequisites
- Docker installed on your system
- Docker Compose installed on your system

## Deployment Steps

### 1. Pull Required Docker Images
```bash
docker pull ghcr.io/freetakteam/freetakserver:latest
docker pull ghcr.io/freetakteam/ui:latest
```

### 2. Create Required Directories
```bash
mkdir data logs config ui-data
```

### 3. Deploy Services
```bash
docker compose -f compose.yaml up -d
```

### 4. Check Service Status
```bash
docker compose -f compose.yaml ps
```

## Accessing Services

### FreeTAK Server
- **TCP COT Port**: 8087
- **SSL COT Port**: 8089
- **Federation Port**: 9000
- **REST API Port**: 19023

### Web UI
- **UI Port**: 5000
- Access via: http://localhost:5000

## Login Credentials

The default login credentials for the web interface are:
- **Username**: `admin`
- **Password**: `admin`

**Important**: Change these credentials immediately after your first login for security reasons.

## Troubleshooting

### Check Logs
```bash
# Check FreeTAK Server logs
docker compose -f compose.yaml logs freetakserver

# Check UI logs
docker compose -f compose.yaml logs freetakserver-ui

# Follow logs in real-time
docker compose -f compose.yaml logs -f freetakserver
```

### Restart Services
```bash
docker compose -f compose.yaml restart
```

### Stop Services
```bash
docker compose -f compose.yaml down
```

## Configuration

The server uses the following environment variables:
- `FTS_IP`: 0.0.0.0 (bind address)
- `FTS_PORT`: 8087 (TCP COT port)
- `FTS_SSL_PORT`: 8089 (SSL COT port)
- `FTS_FEDERATION_PORT`: 9000 (Federation port)
- `FTS_API_PORT`: 19023 (REST API port)

The UI uses the following environment variables:
- `FTS_UI_EXPOSED_IP`: 0.0.0.0 (bind address for UI)
- `FTS_SERVER_HOST`: freetakserver (hostname of the FTS server)
- `FTS_SERVER_PORT`: 19023 (API port of the FTS server)
- `FTS_IP`: freetakserver (hostname for API connections)
- `FTS_API_PORT`: 19023 (API port for connections)
- `FTS_COT_PORT`: 8087 (TCP COT port)
- `FTS_SSL_COT_PORT`: 8089 (SSL COT port)
- `FTS_FED_PORT`: 9000 (Federation port)
- `FTS_USER_ADDRESS`: freetakserver (user address for connections)

Persistent data is stored in:
- `./data`: Server data
- `./logs`: Log files
- `./config`: Configuration files
- `./ui-data`: UI data (including database)

## Common Issues and Solutions

### UI Not Accessible
If the UI is not accessible, ensure:
1. The `FTS_UI_EXPOSED_IP` environment variable is set to `0.0.0.0`
2. The UI container has proper volume mounts for database access
3. The correct ports are exposed in the compose file

### Database Connection Errors
If you see database connection errors in the UI logs:
1. Ensure the `ui-data` directory exists and has proper permissions
2. Check that the volume mapping for the UI is correct in the compose file

### Login Authentication Failed
If you receive authentication errors after entering the default credentials:
1. Ensure the `FTS_IP` environment variable in the UI service is set to `freetakserver` (the service name)
2. Verify that both containers are running and can communicate with each other
3. Check the server logs to confirm it's fully initialized
4. The server may take a minute to fully start up after the containers are running

### Connection Refused Errors
If you see "Connection refused" errors when trying to log in:
1. This typically means the UI cannot connect to the server's API
2. Ensure the `FTS_IP` and `FTS_API_PORT` environment variables are correctly set in the UI service
3. Verify that port 19023 is properly exposed in the server service
4. Check that both services are on the same Docker network