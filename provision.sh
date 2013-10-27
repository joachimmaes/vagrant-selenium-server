#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

HOME_BIN=/home/vagrant/bin
mkdir -p $HOME_BIN
chown -R vagrant:vagrant $HOME_BIN
echo "export PATH=\"$HOME_BIN:$PATH\"" >> /home/vagrant/.profile
echo "export PATH=\"$HOME_BIN:$PATH\"" >> /home/vagrant/.zshenv

apt-get update > /dev/null
apt-get -y install build-essential git-core unzip x11vnc

#xvfb
apt-get -y install xvfb
#cp /vagrant/bin/start_xvfb.sh $HOME_BIN && chown vagrant:vagrant $HOME_BIN/start_xvfb.sh
cp /vagrant/init/xvfb.conf /etc/init
echo "DISPLAY=:99" >> /etc/environment

#chrome
apt-get -y install chromium-browser 
wget -q http://chromedriver.googlecode.com/files/chromedriver_linux64_21.0.1180.4.zip
unzip chromedriver_linux64_21.0.1180.4.zip
chown vagrant:vagrant chromedriver && mv chromedriver $HOME_BIN/chromedriver

#firefox
apt-get -y install firefox 

#selenium server
apt-get -y install openjdk-7-jre-headless
wget -q http://selenium.googlecode.com/files/selenium-server-standalone-2.37.0.jar
mv selenium-server-standalone-2.37.0.jar $HOME_BIN && chown vagrant:vagrant $HOME_BIN/selenium-server-standalone-2.37.0.jar
#cp /vagrant/bin/start_selenium_server.sh $HOME_BIN && chown vagrant:vagrant $HOME_BIN/start_selenium_server.sh
cp /vagrant/init/selenium-server.conf /etc/init

#ffmpeg
apt-get -y install libmp3lame-dev libass4 ffmpeg
wget -q -O ffmpeg https://dl.dropboxusercontent.com/s/zga5ccy7qqc0zke/ffmpeg?dl=1
mv ffmpeg $HOME_BIN && chmod +x $HOME_BIN/ffmpeg && chown vagrant:vagrant $HOME_BIN/ffmpeg
#cp /vagrant/bin/ffmpeg $HOME_BIN && chown vagrant:vagrant $HOME_BIN/ffmpeg
cp /vagrant/bin/start_record_video.sh $HOME_BIN && chown vagrant:vagrant $HOME_BIN/start_record_video.sh
