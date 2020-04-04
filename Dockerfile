FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install -y python3.7 curl ssh sudo

RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
    && python3.7 /tmp/get-pip.py \
    && rm /tmp/get-pip.py \
    && pip install fabric2 \
    && pip install supervisor

COPY supervisor/ssh-program.conf /etc/supervisor/conf.d/
COPY supervisor/supervisord.conf /etc/supervisor/
RUN mkdir /run/sshd
CMD ["/usr/local/bin/supervisord"]