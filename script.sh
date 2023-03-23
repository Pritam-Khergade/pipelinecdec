#!/bin/bash
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y 
sudo amazon-linux-extras install java-openjdk11 -y 
#sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install jenkins -y 
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

