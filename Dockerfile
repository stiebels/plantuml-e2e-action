FROM python:3.10-slim


RUN apt-get update && apt-get install -y \
    default-jdk \
    default-jre \
	ca-certificates \
	wget \
	graphviz \
	fonts-droid-fallback

ENV JAVA_HOME /lib/jvm/java-11-openjdk-amd64/bin/java

RUN pip3 install --no-cache --upgrade pip

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "-h" ]


