#!/bin/sh
set -e

[ -z "${PASSWORD}" ] && PASSWORD=gitpwd
[ -z "${PROJECT}" ] && PROJECT="project.git"

# set password
echo "git:$1" | chpasswd

/usr/sbin/sshd -D &
ssh_pid=$!

chown -R git:git /home/git/.ssh /etc/ssh /opt/git
# git init when path is empty
if [ $(ls -A /opt/git |wc -l) -eq 0 ]
then
        mkdir -p /opt/git/${PROJECT}
        cd /opt/git/${PROJECT} && git --bare init
        chown -R git:git /opt/git/${PROJECT}
        mkdir /tmp/init && cd /tmp/init
        git init
        git config --global user.email test@ebaotech.com
        git config core.sshCommand "ssh -i /home/git/.ssh/private-key -o StrictHostKeyChecking=no"
        echo "init" >init.txt
        git add .
        git commit -m 'initial commit'
        git remote add origin ssh://git@localhost/opt/git/${PROJECT}
        chown -R git:git /tmp/init /home/git/.ssh
        gosu git chmod 600 /home/git/.ssh/*
        gosu git git push origin master
fi
kill $ssh_pid
[ ! -d /opt/git/log ] && mkdir /opt/git/log
chown git:git /etc/shadow /opt/git/log
exec gosu git /usr/sbin/sshd -D -p 9999 -E /opt/git/log/ssh.log
