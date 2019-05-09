FROM alpine:3.9

ADD ./key /home/git/.ssh/
ADD ./start.sh /start.sh

RUN apk add --no-cache openssh git && \
  apk add gosu --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ && \
  ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
  ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
  ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
  adduser git -D  && \
  mkdir -p /opt/git

WORKDIR /opt/git

CMD ["/start.sh"]
