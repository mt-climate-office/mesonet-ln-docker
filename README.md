# mesonet-ln-docker
A docker image standing up a LoggerNet Linux server

## Launch SSH agent
```
eval "$(ssh-agent -s)"
ssh-add /git/.ssh/id_ed25519
```

## Build Loggernet
```
DOCKER_BUILDKIT=1 docker build --ssh default -t loggernet --no-cache loggernet
```

## Run
```
docker run -d --privileged \
--name loggernet \
--restart unless-stopped \
-p 6789:6789 \
-v /var/opt/Loggernet/data:/var/opt/CampbellSci/LoggerNet/data \
-e SSH_KEY="`cat /git/.ssh/id_ed25519`" \
loggernet

docker run -d \
--name caddy \
--restart unless-stopped \
-p 80:80 \
-v $PWD/caddy/Caddyfile:/etc/caddy/Caddyfile \
-v /var/opt/Loggernet:/var/opt/Loggernet \
-v caddy_data:/data \
caddy:2.3.0
```

## Interact
```
docker exec -it loggernet bash

```

## Stop
```
docker stop loggernet
docker stop caddy
```

## Rebuild
```
docker stop loggernet
docker rm loggernet

cd /git/mesonet-ln-docker
sudo git pull

# sudo rsync -avzh kbocinsky@fcfc-mesonet-ln.cfc.umt.edu:/var/opt/Loggernet/ /var/opt/Loggernet/

eval "$(ssh-agent -s)"
ssh-add /git/.ssh/id_ed25519

DOCKER_BUILDKIT=1 docker build --ssh default -t loggernet --no-cache loggernet

docker run -d --privileged \
--name loggernet \
--restart unless-stopped \
-p 6789:6789 \
-v /var/opt/Loggernet:/var/opt/CampbellSci/LoggerNet \
-e SSH_KEY="`cat /git/.ssh/id_ed25519`" \
loggernet

```
