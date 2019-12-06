# Start Develop

```bash
cp .env.example .env
```

```bash
docker-compose up --build -d
```

```bash
docker exec -d apache php artisan key:generate
docker exec -d apache php artisan optimize
```
