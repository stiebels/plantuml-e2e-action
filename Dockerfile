FROM alpine:3.11

# Install plantuml dependencies as well as python
RUN apk add --no-cache openjdk11-jre graphviz ttf-droid ttf-droid-nonlatin build-base python3 python3-dev
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "-h" ]

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip
