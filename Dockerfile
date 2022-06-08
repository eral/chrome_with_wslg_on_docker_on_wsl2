FROM ubuntu:20.04

USER root
WORKDIR /root
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install curl x11-apps	\
    && echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google-chrome.list \
    && curl https://dl-ssl.google.com/linux/linux_signing_key.pub >> /etc/apt/trusted.gpg.d/google-chrome.asc \
    && apt-get update \
    && apt-get -y install google-chrome-stable \
    && rm -f /etc/apt/trusted.gpg.d/google-chrome.asc /etc/apt/trusted.gpg.d/google-chrome.gpg \
    && rm -f /etc/apt/sources.list.d/google-chrome.list \
    && apt-get -y purge --auto-remove curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD google-chrome --no-sandbox
