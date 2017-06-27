FROM ruby:2.4-slim

RUN apt-get update && apt-get install -y \
    build-essential libpq-dev \
    nodejs

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install -j4

ADD . $APP_HOME
