FROM ruby:3.2

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile* /app/

RUN bundle install

ADD . /app

CMD ["./send_tweets_forever.sh"]
