FROM ruby:2.7.2-slim

LABEL maintainer="digitalsleuth"
LABEL version="1.0"
LABEL description="Docker for dradis-ce"

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install git libpq-dev libsqlite3-dev build-essential -y && \
gem install bundler:2.2.8 RedCloth:4.3.2 

RUN git clone -b main --single-branch https://github.com/digitalsleuth/dradis-ce.git /dradis-ce
WORKDIR /dradis-ce

RUN /usr/local/bin/bundle install && \
/usr/local/bin/ruby /dradis-ce/bin/setup && \
DEBIAN_FRONTEND=noninteractive apt-get remove -y build-essential git --purge

EXPOSE 8080
CMD /usr/local/bin/bundle exec rails server -p $BIND_PORT -b $BIND_IP
