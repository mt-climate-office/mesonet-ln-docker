# ln-docker
A public Docker build for LoggerNet that uses SSH to access the private LoggerNet repo

## Build
```
DOCKER_BUILDKIT=1 docker build -t loggernet https://github.com/mt-climate-office/ln-docker

```

## Run
```
docker run -d -p 6789:6789 --name loggernet --rm loggernet
```

## Interact
```
docker exec -it loggernet bash
```

## Stop
```
docker stop loggernet
```