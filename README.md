# XL Deploy image for Docker


This Dockerfile will build a CentOS based image, running XL Deploy.


## Prereq

* Add XL Deploy (Community) archive to this directory.
* Add a 'deployit-license.lic' licensefile.
* Update the Dockerfile with the correct XL Deploy archive name.


## Build

    docker build -t xldeploy .


## Usage

To start a container based on this image, use something like:

    docker run -d -p 4516:4516 --name xldeploy xldeploy


This will start a container running XL Deploy in the background. The 
status for this running container can be checked with: 

    docker exec -ti xldeploy /bin/bash
    docker logs xldeploy


> Martijn Pepping <martijn@xbsd.nl>

