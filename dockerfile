FROM ruby:2.7-alpine
RUN apk update
RUN apk add --no-cache build-base gcc cmake git
RUN gem update --system && gem update bundler && gem install bundler jekyll:3.9.3 minima:2.5.1 jekyll-feed:0.15.1 sass:3.7.4 rexml i18n
EXPOSE 4000

