FROM gcc:15.2.0 AS dev
COPY vtun-3.0.4.patch /
RUN apt-get update
RUN apt-get install -y liblzo2-dev yacc flex bison
RUN curl -L https://sourceforge.net/projects/vtun/files/vtun/3.0.4/vtun-3.0.4.tar.gz \
    | tar -zxvf -
RUN patch -p0 < /vtun-3.0.4.patch
RUN cd /vtun-3.0.4/ && autoconf && ./configure
RUN make -C /vtun-3.0.4    

FROM ubuntu:24.04
COPY --from=dev /vtun-3.0.4/vtund /bin
COPY vtund-*-example.conf /etc
RUN apt-get update && apt-get install -y liblzo2-2 net-tools \
    && mkdir -p /usr/local/var/run /usr/local/var/lock/vtund /usr/local/var/log/vtund \
    && ln -sf /usr/local/etc/vtund.conf /etc/vtund.conf
ENTRYPOINT [ "/bin/vtund", "-n" ]
CMD [ "-s" ]
