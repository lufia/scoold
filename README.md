# scoold
Dockernized [Scoold](https://github.com/Erudika/scoold)

## Use

```console
$ docker run --rm -e PARA_APP_NAME=scoold -e PARA_PORT=8000 -e PARA_ENDPOINT=http://para:8080 lufia/scoold:latest
```

## Configuration

```
FROM	lufia/scoold:latest

ADD	access_key secret_key /app/
ENV	ACCESS_KEY_PATH=/app/access_key
	SECRET_KEY_PATH=/app/secret_key
```

TODO
