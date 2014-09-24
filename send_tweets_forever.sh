#!/usr/bin/env bash

while true; do
  bundle exec ruby ./send_tweets.rb
  sleep 600
done
