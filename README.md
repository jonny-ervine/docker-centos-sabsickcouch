# docker-centos-sabsickcouch
## CentOS 7 with SABnzbd, SickRage, and CouchPotato

The Dockerfile should intialise the CentOS image and subscribe to the EPEL and RepoForge repositories. The pre-requisites for SABnzbd, SickRage, and CouchPotato are then installed via yum.

The EPEL and RepoForge repositories provide:

    python-cheetah par2cmdline supervisor unrar 

The SABnzbd, SickRage, and CouchPotato daemons are controlled via the supervisord daemon which has a web front end exposed via port 9002. Default username and password for the web front end is admin:admin.

The SABnzbd software is downloaded as a tarball from sourceforge and the SickRage and CouchPotato software packages are downloaded as zip files from github and then extracted into the docker container ready for use.

The container can be run as follows:

    docker pull jervine/docker-centos-sabsickcouch
    docker run -d -n <optional name of container> -h <optional host name of container> -e TZ="<optional timezone> -v /<config directory on host>:/config -v <data directory on host>:/data -v /<download directory on host>:/downloads -p 5050:5050 -p 8080:8080 -p 8081:8081 -p 9002:9002 jervine/docker-centos-sickrage

THe TZ variable allows the user to set the correct timezone for the container and should take the form "Europe/London". If no timezone is specified then UTC is used by default. The timezone is set up when the container is run. Subsequent stops and starts will not change the timezone.
