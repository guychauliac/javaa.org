FROM ruby:2.7-alpine
RUN apk update
RUN apk add --no-cache build-base gcc cmake git
RUN gem update --system && gem update bundler && gem install bundler jekyll 
RUN gem install minima jekyll-feed sass-embedded rexml i18n
EXPOSE 4000

