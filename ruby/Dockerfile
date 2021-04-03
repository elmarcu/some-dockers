FROM ruby:2.6.4
ENV RAILS_VERSION 5.0.1
RUN gem install rails --version "$RAILS_VERSION"
RUN gem install bundle
RUN apt-get update && apt-get install -y libv8-dev nodejs
