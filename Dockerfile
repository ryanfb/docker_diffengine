FROM python:3.6-slim
MAINTAINER ryan.baumann@gmail.com

RUN pip install --process-dependency-links diffengine

RUN apt-get update && apt-get install -y cron locales-all \
      build-essential chrpath libssl-dev libxft-dev \
      libfreetype6 libfreetype6-dev \
      libfontconfig1 libfontconfig1-dev \
      wget

ENV PHANTOM_JS phantomjs-1.9.8-linux-x86_64
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
RUN tar xvjf $PHANTOM_JS.tar.bz2
RUN mv $PHANTOM_JS /usr/local/share
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

ADD run-diffengine.sh /run-diffengine.sh
ADD setup-crontab.sh /setup-crontab.sh
RUN touch /var/log/cron.log

RUN mkdir /diffengine
RUN touch /diffengine/diffengine.log /tmp/diffengine.log

VOLUME ["/diffengine"]

ENV DIFFENGINE_TIMEOUT 1h

CMD env >> /etc/environment && /setup-crontab.sh && cron && tail -f /diffengine/diffengine.log
