#! /bin/bash

# Download the release v.0.10.0
mkdir app && cd app
sudo yum update -y
sudo yum install -y unzip
wget https://github.com/servian/TechChallengeApp/releases/download/v.0.10.0/TechChallengeApp_v.0.10.0_linux64.zip
unzip TechChallengeApp_v.0.10.0_linux64.zip -d ./

# Deploy the application
./TechChallengeApp serve
