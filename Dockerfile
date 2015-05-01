# Base on latest CentOS image
FROM centos:latest
MAINTAINER Jonathan Ervine <jon.ervine@gmail.com>
ENV container docker

# Install updates and enable EPEL and repoforge repositories for SABnzbd, SickRage, and CouchPotato pre-requisites
RUN yum update -y; yum clean all
RUN yum install -y http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum install -y http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
RUN yum install -y tar gzip python-cheetah par2cmdline unzip pyOpenSSL unrar supervisor
ADD python-yenc-0.4.0-4.el7.centos.x86_64.rpm /python-yenc-0.4.0-4.el7.centos.x86_64.rpm
RUN yum install -y /python-yenc-0.4.0-4.el7.centos.x86_64.rpm
RUN rm -f /python-yenc-0.4.0-4.el7.centos.x86_64.rpm
RUN yum clean all

# Download and extract SABnzbd from sourceforge
RUN curl http://jaist.dl.sourceforge.net/project/sabnzbdplus/sabnzbdplus/0.7.20/SABnzbd-0.7.20-src.tar.gz > /SABnzbd.tar.gz
RUN tar zxvf /SABnzbd.tar.gz
RUN rm /SABnzbd.tar.gz

# Download and extract the latest SickRage release
RUN curl -L https://github.com/SiCKRAGETV/SickRage/archive/master.zip -o /SickRage.zip
RUN unzip /SickRage.zip
RUN rm -f /SickRage.zip

# Download and extract the latest SickRage release
RUN curl -L https://github.com/RuudBurger/CouchPotatoServer/archive/master.zip -o /CouchPotatoServer.zip
RUN unzip /CouchPotatoServer.zip
RUN rm -f /CouchPotatoServer.zip

ADD supervisord.conf /etc/supervisord.conf
ADD sabnzbd.ini /etc/supervisord.d/sabnzbd.ini
ADD sickrage.ini /etc/supervisord.d/sickrage.ini
ADD couchpotato.ini /etc/supervisord.d/couhcpotato.ini
ADD start.sh /usr/sbin/start.sh
RUN chmod 755 /usr/sbin/start.sh

VOLUME /config
VOLUME /data
VOLUME /downloads

# Start SABnzbd
EXPOSE 5050 8080 8081 8090 9002
ENTRYPOINT ["/usr/sbin/start.sh"]
