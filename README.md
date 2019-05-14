# Takí Back-end Project

## How to run
After initializing the database:
```bash
go run main.go
```

## Docker Cheat Sheet

Kill All Containers
```bash
docker kill `docker ps -q`
```

Remove all stopped containers
```bash
docker rm $(docker ps -a -q) 
```

Remove every untagged image
```bash
docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}')
```
