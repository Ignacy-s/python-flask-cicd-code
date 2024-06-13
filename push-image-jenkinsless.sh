#!/bin/bash

# A code snippet to build and push a docker image to an AWS repo, taken from StackOverflow (more info in project journal).

# Requirements:
# - AWS cli installed and logged in
# - AWS ECR repo provisioned
# - jq installed
# - script run in the directory with the Dockerfile

ACCOUNT=$(aws sts get-caller-identity | jq -r .Account)
REGION='eu-north-1'
REPO='flask_cicd_repo'

docker build -t ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${REPO} .

aws ecr get-login-password \
    --region ${REGION} \
| docker login \
    --username AWS \
    --password-stdin ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com

docker push ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${REPO}
