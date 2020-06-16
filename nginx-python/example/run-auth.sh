docker run -it --rm \
-p 8000:80 \
-e AUTH_USERNAME=guest \
-e AUTH_PASSWORD=fooBar! \
-v $PWD:/site \
yakworks/nginx-python