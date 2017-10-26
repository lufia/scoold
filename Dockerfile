FROM openjdk:8-jre
MAINTAINER lufia <lufia@lufia.org>

ENV	VERSION=1.25.5 \
	ARCHIVE_URL=https://github.com/Erudika/scoold/releases/download \
	ACCESS_KEY_PATH=/var/lib/para/access_key \
	SECRET_KEY_PATH=/var/lib/para/secret_key

RUN	useradd -s /bin/rbash -u 10000 scoold && \
	mkdir -p /app /var/lib/para && \
	touch /app/para.log && \
	chown -R scoold /app /app/*.log
WORKDIR /app
RUN	curl -L -O $ARCHIVE_URL/$VERSION/scoold-$VERSION.jar && \
	mv scoold-$VERSION.jar scoold.jar && \
	touch application.conf && \
	chown scoold application.conf
ADD	startup.bash /app/
RUN	chmod 755 startup.bash

EXPOSE 8000

VOLUME ["/var/lib/para"]

USER scoold
CMD	["/app/startup.bash"]
