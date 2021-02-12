# mesonet-ln-docker
A docker image standing up a LoggerNet Linux server

## Launch SSH agent
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

## Build
```
DOCKER_BUILDKIT=1 docker build --ssh default -t loggernet git@github.com:mt-climate-office/loggernet

```

## Run
```
docker run -d -p 6789:6789 --e SSH_KEY="`cat <private key>`" -name loggernet --rm loggernet
```

## Interact
```
docker exec -it loggernet bash
```

## Stop
```
docker stop loggernet
```