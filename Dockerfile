FROM ruby
ENV RACK_ENV production
CMD bundle exec ruby ./send_tweets_forever.rb
