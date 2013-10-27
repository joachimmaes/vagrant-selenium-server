vagrant-selenium-server
=======================

A recipe to build a Vagrant box that runs Selenium Server.

The produced precise64-selenium-server.box includes Firefox and Chromium that run on Xvfb.  It also includes FFmpeg to allow to make a video recording of test runs.


Recipe
------
Because the provisioning step takes some minutes, the idea is to up this box once and then package it as a new base box.  Thus, it starts with the precise64 base box, resulting in a new precise64-selenium-server base box.
 
<pre>
$ vagrant up
$ vagrant package --output precise64-selenium-server.box

$ vagrant box list
$ vagrant box remove precise64-selenium-server
$ vagrant box add precise64-selenium-server precise64-selenium-server.box
$ vagrant destroy

$ rm precise64-selenium-server.box
</pre>


Usage
-----
Assume we have a configuration as in test/Vagrantfile.

<pre>
$ vagrant up
</pre>
Xvfb and Selenium Server will be started automatically during boot time.

From a test client, use: 
<pre>
WebDriver driver = new RemoteWebDriver(new URL("http://192.168.44.10:4444/wd/hub"), DesiredCapabilities.firefox());
</pre>  
To record video:
<pre>
$ vagrant ssh -- /home/vagrant/bin/start_record_video.sh /vagrant/video.mov
</pre>
This will start recording whatever plays on display :99

To watch what is happening you can expose the Xvfb via VNC, at a guest shell:
<pre>
$ x11vnc -storepasswd
$ x11vnc -rfbauth /home/vagrant/.vnc/passwd  -display :99 -many
</pre>
Alternate approach using SSH tunneling, at the host shell, e.g.:
<pre>
$ ssh -L 5900:localhost:5900 vagrant@192.168.44.10 'x11vnc -rfbauth /home/vagrant/.vnc/passwd -localhost -display :99 -many'
</pre>

You can also check the open session on Selenium Server, e.g. at http://192.168.44.10/wd/hub 


References
----------
Inspiration and parts taken from:

* <https://github.com/mkremer/echo>
* <https://github.com/leonid-shevtsov/headless>
* <http://superuser.com/questions/540391/x-error-of-failed-request-badcursor-invalid-cursor-parameter-when-recording-x>
* <https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide>
* <http://executeautomation.com/blog/running-test-in-remote-machine-with-new-webdriver-functionality-grid-2-2/>

