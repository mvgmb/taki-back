# How to Build an Run DB using Docker

## Build taki/mysql image
```bash
docker build -t taki/mysql .
```

## Run taki/mysql (standalone)
```bash
docker run --name taki_db -p3306:3306 taki/mysql
```

## Connect to mysql through bash
```bash
docker exec -it taki_db /bin/bash
```

## Login after connecting to taki_db
```bash
mysql -uuser -ppassword
#or
mysql -uroot -prootpassword
```