FROM ubuntu:groovy
MAINTAINER fromanf@gmail.com

# Evita mensajes del tipo: 'debconf: unable to initialize frontend: Readline'.
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y sudo amule-daemon && rm -rf /var/lib/apt/lists/*

# Add startup script
ADD amule.sh /home/amule/amule.sh

# Final cleanup
RUN chmod a+x /home/amule/amule.sh

EXPOSE 4711/tcp 4712/tcp 4672/udp 4665/udp 4662/tcp 4661/tcp

ENTRYPOINT ["/home/amule/amule.sh"]
