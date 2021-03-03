# mesonet-ln-docker
A docker image standing up a LoggerNet Linux server

## Launch SSH agent
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

## Build
```
DOCKER_BUILDKIT=1 docker build --ssh default -t loggernet --no-cache github.com/mt-climate-office/mesonet-ln-docker

```

## Run
```
docker run -d -p 6789:6789 --restart always -e SSH_KEY="`cat ~/.ssh/id_ed25519`" --name loggernet loggernet
```

## Interact
```
docker exec -it loggernet bash

# backup

```

## Stop
```
docker stop loggernet
```