FROM ruby:2.6

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile* /app/

RUN bundle install --without test development

ADD . /app

CMD ["./send_tweets_forever.sh"]
