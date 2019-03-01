FROM alpine:3.7

EXPOSE 9999
VOLUME /usr/src/app
WORKDIR /usr/src/app

RUN apk add --no-cache \
    uwsgi-python3 \
    python3 \
    bash

COPY flask /flask
RUN pip3 install --no-cache-dir -r /flask/requirements.txt

CMD [ "/flask/wait-for-it.sh", "mongo:27017", "--", \
      "uwsgi", "--socket", "0.0.0.0:9999", \
               "--uid", "uwsgi", \
               "--plugins", "python3", \
               "--protocol", "uwsgi", \
               "--wsgi", "app:app"]
