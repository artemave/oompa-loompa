FROM ruby:2.2.2

RUN mkdir -p /app
WORKDIR /app

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN bundle install --system --without test:development

ADD . /app

ENV RACK_ENV production
CMD ["./send_tweets_forever.sh"]
