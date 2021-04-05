FROM ruby:2.6.4
ENV RAILS_VERSION 5.0.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y libv8-dev nodejs yarn

RUN gem install rails --version "$RAILS_VERSION"
RUN gem install bundle
RUN gem install sqlite3
