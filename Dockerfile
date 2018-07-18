FROM fluent/fluentd:stable-onbuild
MAINTAINER Ryanoolala <ryan_goh@tech.gov.sg>
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.4.0/bin:$PATH
ENV APK_ADD=".build-deps sudo build-base ruby-dev"
ENV APK_DEL=".build-deps sudo build-base ruby-dev"

ARG GEM_VERSION="-v 2.4.0"
ARG GEM_NAME="fluent-plugin-elasticsearch"
RUN apk add --update --no-cache --virtual $APK_ADD && \
      sudo gem install "${GEM_NAME}" ${GEM_VERSION} && \
      sudo gem sources --clear-all && \
      apk del ${APK_DEL} && rm -rf /var/cache/apk/* \
        /home/fluent/.gem/ruby/2.3.0/cache/*.gem

RUN deluser --remove-home postmaster
RUN deluser --remove-home cyrus
RUN deluser --remove-home mail
RUN deluser --remove-home news
RUN deluser --remove-home uucp
RUN deluser --remove-home operator
RUN deluser --remove-home man
RUN deluser --remove-home cron
RUN deluser --remove-home ftp
RUN deluser --remove-home sshd
RUN deluser --remove-home at
RUN deluser --remove-home squid
RUN deluser --remove-home xfs
RUN deluser --remove-home games
RUN deluser --remove-home postgres
RUN deluser --remove-home vpopmail
RUN deluser --remove-home ntp
RUN deluser --remove-home smmsp
RUN deluser --remove-home guest

COPY ./scripts/version-info /usr/bin
EXPOSE 24284
