FROM ruby
ENV RACK_ENV production
ENV BUNDLE_WITHOUT development:test
CMD bundle exec ruby ./send_tweets_forever.rb
