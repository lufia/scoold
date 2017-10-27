FROM openjdk:8-jre
MAINTAINER lufia <lufia@lufia.org>

VOLUME ["/var/lib/para"]

ADD startup.bash /
RUN chmod 755 /startup.bash
CMD ["/startup.bash"]
