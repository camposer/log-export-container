#!/bin/bash

docker build -t log-export-container .
docker run -p 5140:5140 \
  -e LOG_EXPORT_CONTAINER_INPUT=$LOG_EXPORT_CONTAINER_INPUT \
  -e LOG_EXPORT_CONTAINER_OUTPUT=$LOG_EXPORT_CONTAINER_OUTPUT \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e S3_BUCKET=$S3_BUCKET \
  -e S3_REGION=$S3_REGION \
  -e S3_PATH=$S3_PATH \
  -e AWS_REGION=$S3_REGION \
  -e LOG_GROUP_NAME=$LOG_GROUP_NAME \
  -e LOG_STREAM_NAME=$LOG_STREAM_NAME log-export-container &

ssh -N -R 5140:localhost:5140 -i $LOG_EXPORT_CONTAINER_SSH_CREDENTIALS $LOG_EXPORT_CONTAINER_SSH_DESTINATION
