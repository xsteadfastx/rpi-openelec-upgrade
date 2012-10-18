#!/bin/bash

# change working directory 
cd /storage

# location of the nightlies
url="http://sources.openelec.tv/tmp/image/openelec-rpi/"

# get base, revision and filename of last build
last_base=`curl -s $url | grep .tar.bz2 | sed 's/.*\(OpenELEC.*\).tar.bz2.*/\1/' | sort | tail -1`
last_revision=`echo $last_base | sed 's/.*\(r[0-9]*\)/\1/'`
last_filename=$last_base.tar.bz2

# folder name is set equal to base
foldername=$last_base

# get currently installed revision
this_revision=`cat /etc/version | sed 's/.*\(r[0-9]*\)/\1/'`

# check if currently installed revision is up-to-date
if [ $this_revision == $last_revision ]
then
    echo "System is up-to-date, no update required."
    exit
else
    echo "Update required, will download latest version."
fi

# download corresponding file to working directory
urltolast=$url/$last_filename
wget $urltolast
echo -e  "Download complete\n"

# uncompressing the tarball
echo "Uncompressing tarball, files extracted:"
tar -xvjf $last_filename

# check if .update folder exists, otherwise create it
if [ ! -d /storage/.update ]; then
    mkdir /storage/.update
fi

# move OpenELEC files (including .md5 files) to update folder
mv $foldername/target/* /storage/.update/
echo -e "\nOpenELEC files succesfully moved to update directory"

# check for newer bootcode
if [ -d $foldername/3rdparty ]; then
    mount -o remount,rw /flash
    mv $foldername/3rdparty/* /flash/
    mount -o remount,ro /flash
    echo -e "\nNewer bootcode installed"
fi

# clean up
rm -r $foldername
rm $last_filename
echo "Temporary files deleted"

# sync and reboot system to apply updates
echo "System will restart shortly"
echo "Enjoy!"
sleep 5s
sync
reboot
