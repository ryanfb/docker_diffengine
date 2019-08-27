FROM arm64v8/python:3.6-slim-buster
MAINTAINER ryan.baumann@gmail.com
COPY qemu-aarch64-static /usr/bin/

RUN apt-get update && apt-get install -y cron locales-all \
      build-essential chrpath libssl-dev libxft-dev \
      libfreetype6 libfreetype6-dev \
      libfontconfig1 libfontconfig1-dev \
      wget zlib1g-dev libjpeg-dev libxml2-dev libxslt1-dev python-dev \
      phantomjs

RUN pip install https://github.com/edsu/htmldiff/tarball/master#egg=htmldiff-0.2
RUN pip install diffengine

ENV QT_QPA_PLATFORM offscreen
RUN phantomjs --version

ADD run-diffengine.sh /run-diffengine.sh
ADD setup-crontab.sh /setup-crontab.sh
RUN touch /var/log/cron.log

RUN mkdir /diffengine
RUN touch /diffengine/diffengine.log /tmp/diffengine.log

VOLUME ["/diffengine"]

ENV DIFFENGINE_TIMEOUT 1h

CMD env >> /etc/environment && /setup-crontab.sh && cron && tail -f /diffengine/diffengine.log
