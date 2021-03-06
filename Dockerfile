FROM python:2-alpine

RUN echo http://dl-3.alpinelinux.org/alpine/edge/community \
         >> /etc/apk/repositories \
 && echo http://dl-3.alpinelinux.org/alpine/edge/main \
         >> /etc/apk/repositories \
 && apk add --no-cache zsh \
                       py2-cryptography \
                       gcc \
                       libffi-dev \
                       musl-dev \
                       openssl-dev \
 && pip install keyring keyrings.alt \
 && apk del gcc \
            libffi-dev \
            musl-dev \
            openssl-dev

ADD . /src
ADD ./docker/.zshrc /root/

RUN cd /src \
 && python setup.py install \
 && rm -rf /src \
 && mkdir /flik-console

WORKDIR /flik-console

CMD zsh

