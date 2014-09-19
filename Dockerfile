FROM ruby:2.1.2

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN bundle install --system --without test:development

ENV RACK_ENV production
CMD ["bundle",  "exec",  "ruby",  "./send_tweets_forever.rb"]
