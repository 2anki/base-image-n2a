FROM node:12-slim

LABEL maintainer Alexander Alemayhu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales python3 python3-pip

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

RUN apt-get update || : && apt-get install python3 python3-pip -y && rm -rf /var/lib/apt/lists/*

COPY ./notion2anki/src/genanki/requirements.txt /tmp/requirements.txt 
RUN pip3 install -r /tmp/requirements.txt
RUN pip3 install pyinstaller

RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*
