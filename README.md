# Takí Back-end Project

## How to run

### To initialize the database

Build taki/mysql image
```bash
docker build -t taki/mysql ./database
```

Run taki/mysql image
```bash
docker run --name taki_db -p3306:3306 taki/mysql
```

To kill and remove taki/mysql container
```bash
docker kill `docker ps -q` &&\
docker rm $(docker ps -a -q)
```

### To run the server api
```bash
go run main.go
```

## Run Docker Compose

```bash
docker-compose up --build --force-recreate --remove-orphans
```

## Kill Docker Compose

```bash
docker-compose down
```

docker run --rm -e DB_ADDR=172.17.0.1 -e DB_PORT=33060 -e DB_USER=user -e DB_PASS=password -e DB_NAME=taki taki/server