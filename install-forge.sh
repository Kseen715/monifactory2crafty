#!/bin/bash
set -e
set -x

# Usage: install-forge.sh <forge-jar-file> <Monifactory-server-zip>

# install forge jar file into the server directory and return error if error

# make "server" dir if not exist
mkdir -p server

# move the forge jar file into the server directory
cp $1 server/forge.jar
cd server

# execute java -jar TheForgeInstallerName.jar --installServer
java -jar forge.jar --installServer


cd ../

# create temp directory
mkdir -p temp

# Move the contents of the overrides folder (from server.zip) into the server directory, this can be done with the command mv overrides/* .
unzip -o $2 -d temp
mv temp/overrides/* server

# remove temp directory
rm -rf temp

# run the server
cd server
./run.sh


# accecp the EULA
echo "eula=true" > eula.txt
