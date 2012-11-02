rpi-openelec-upgrade
====================

Script to update to the latest nightly version of openelec for the Raspberry Pi in a SSH-Session. There is a thread in the openelec forums about a update script (http://openelec.tv/forum/133-installation/42383-update-script-for-openelec-on-raspberry-pi) but no central place to get it. So i thought to gather everything in a git repo. So thank everyone in the original thread...

Using it
--------

1. Login to your Raspberry Pi using SSH
2. Download the update.sh script with `curl https://raw.github.com/xsteadfastx/rpi-openelec-upgrade/master/update.sh > update.sh`
3. Make it with `chmod +x update.sh` executable
4. Running it with `./update.sh`

Warning
-------

Use it on your own risk!!!

Alternatives
------------

I found out that there is a really awesome Update script from ericab under https://github.com/wavrunrx/OpenELEC_Dev 
