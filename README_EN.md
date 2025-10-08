# FreeTAK Server Docker Deployment

Docker deployment for FreeTAK Server using official pre-built images.

## Requirements

- Docker
- Docker Compose

## Quick Start

1. **Clone the repository:**
```bash
git clone <your-repo>
cd FreeTAK
```

2. **Create required directories:**
```bash
mkdir -p data logs config ui-data
```

3. **Deploy services:**
```bash
docker-compose up -d
```

4. **Check service status:**
```bash
docker-compose ps
```

## Ports

| Service | Port | Description |
|---------|------|-------------|
| FreeTAK Server | 8087 | TCP COT |
| FreeTAK Server | 8089 | SSL COT |
| FreeTAK Server | 9000 | Federation |
| FreeTAK Server | 19023 | REST API |
| FreeTAK Server UI | 5000 | Web UI |

## Configuration

### Environment Variables

The deployment uses environment variables defined in the compose.yaml file:

```yaml
# FreeTAK Server
FTS_IP=0.0.0.0
FTS_PORT=8087
FTS_SSL_PORT=8089
FTS_FEDERATION_PORT=9000
FTS_API_PORT=19023

# FreeTAK Server UI
FTS_UI_EXPOSED_IP=0.0.0.0
FTS_SERVER_HOST=freetakserver
FTS_SERVER_PORT=19023
FTS_COT_PORT=8087
FTS_SSL_COT_PORT=8089
FTS_FED_PORT=9000
FTS_USER_ADDRESS=freetakserver
```

### Persistent Data

Data is persisted in the following directories:
- `./data` - FreeTAK Server data
- `./logs` - FreeTAK Server logs
- `./config` - Configuration files
- `./ui-data` - UI data (including database)

## Management

### Start Services
```bash
docker-compose up -d
```

### Stop Services
```bash
docker-compose down
```

### Restart Services
```bash
docker-compose restart
```

### View Logs
```bash
# All services
docker-compose logs

# Specific service
docker-compose logs freetakserver
docker-compose logs freetakserver-ui
```

### Update Services
```bash
docker-compose pull
docker-compose up -d
```

## Accessing Services

### Web UI
- URL: `http://localhost:5000`
- Default Credentials: `admin` / `password`

**Important**: Change the default credentials immediately after your first login for security reasons.

### Client Connections

#### ATAK
- Server: `your-server-ip:8087`
- SSL: `your-server-ip:8089`

#### WinTAK
- Server: `your-server-ip:8087`
- SSL: `your-server-ip:8089`

## Security

1. Change default passwords after first login
2. Use a firewall to restrict access to necessary ports only
3. Regularly update containers

## Troubleshooting

### Check Service Status
```bash
docker-compose ps
```

### View Logs
```bash
docker-compose logs -f freetakserver
```

### Enter Container Shell
```bash
docker-compose exec freetakserver bash
```

### Common Issues

#### UI Not Accessible
- Ensure `FTS_UI_EXPOSED_IP` is set to `0.0.0.0`
- Check that the UI container has proper volume mounts
- Verify ports are correctly exposed

#### Authentication Failed
- Default credentials are `admin` / `password`
- Ensure both containers are running and can communicate
- Check server logs for initialization completion

#### Connection Issues
- Verify that both services are on the same Docker network
- Check that environment variables are correctly set
- Ensure required ports are properly exposed