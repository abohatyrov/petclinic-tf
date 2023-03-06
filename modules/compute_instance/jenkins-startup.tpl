#/bin/bash

sudo apt update
sudo apt install -y default-jre openjdk-17-jdk wget git docker.io

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins

sudo usermod -a -G docker jenkins
