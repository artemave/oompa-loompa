#!/bin/bash

for container_id in `docker ps -q`; do
  container_name=$(docker inspect --format='{{.Name}}' $container_id)

  if [[ $container_name =~ "mongodb" ]]; then
    mongo_is_running=1
  fi
done

if [[ ! $mongo_is_running ]]; then
  DATA_DIR=/opt/mongo/data
  mkdir -p $DATA_DIR

  docker rm mongodb || :
  docker run -d -p 27017:27017 -v $DATA_DIR:/data/db --name mongodb mongo
fi

docker build -t oompa .
docker build -t oompa-auth -f Dockerfile-auth .

docker stop authorize-accounts || :
docker rm authorize-accounts || :
docker run -p '4567:4567' -d --link mongodb:mongodb -e TWITTER_KEY=$TWITTER_API_KEY -e TWITTER_SECRET=$TWITTER_API_SECRET --name authorize-accounts oompa-auth

docker stop tweet_sender || :
docker rm tweet_sender || :
docker run -d --link mongodb:mongodb -e GOOGLE_ALLOWED_IP=$GOOGLE_ALLOWED_IP \
  -e GOOGLE_API_KEY=$GOOGLE_API_KEY \
  -e TWITTER_KEY=$TWITTER_API_KEY \
  -e TWITTER_SECRET=$TWITTER_API_SECRET --name tweet_sender oompa
