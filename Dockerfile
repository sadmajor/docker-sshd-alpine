FROM alpine

# add openssh and clean
RUN apk add --update openssh \
&& rm  -rf /tmp/* /var/cache/apk/*

# make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

# set port to 80
COPY sshd_config /etc/ssh/sshd_config

# add entrypoint script
ADD docker-entrypoint.sh /usr/local/bin

RUN mkdir /root/.ssh

COPY alpine_sshd_id_rsa.pub /root/.ssh/authorized_keys

EXPOSE 80
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]