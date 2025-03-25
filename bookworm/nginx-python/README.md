# nginx image with python 3.6 installed.

starts with nginx base image that uses alpine 3.9 as that has the the right pyton version when doing apk install

adds in bash as well.

changes default to map to `site` so its easier to run and map volume

## Serving static content

to run against the current dir you in
`docker run -p 8000:80 -v $PWD:/site -d yakworks/nginx-python` 
or `docker run -it --rm -p 8000:80 -v $PWD:/site yakworks/nginx-python`

Then you can hit http://localhost:8080 or http://host-ip:8080 in your browser.

or with a dockerfile

```
FROM yakworks/nginx-python
COPY static-html-directory /usr/share/nginx/html
```

Place this file in the same directory as your directory of content ("static-html-directory"), run docker build -t some-content-nginx ., then start your container:

$ docker run --name some-nginx -d some-content-nginx

Exposing external port

$ docker run --name some-nginx -d -p 8080:80 some-content-nginx

Then you can hit http://localhost:8080 or http://host-ip:8080 in your browser.

## Override Config

if you want to override the default.conf map volume file to the /etc/nginx/conf.d/default.conf

```
docker run -p 8000:80 \
-v /host/some-content:/site \
-v /host/default.conf:/etc/nginx/conf.d/default.conf \
-d yakworks/nginx-python
```

## With Basic Auth

If a AUTH_USERNAME is passed in then it will use auth.conf to require a login to access
the site. Takes care of running htpasswd to generate the hash form the AUTH_PASSWORD

```
docker run -p 8000:80 \
-e AUTH_USERNAME=guest \
-e AUTH_PASSWORD=fooBar! \
-v /host/some-content:/site \
-d yakworks/nginx-python
```