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