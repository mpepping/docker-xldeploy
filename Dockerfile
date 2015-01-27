FROM centos:latest

MAINTAINER Martijn Pepping <martijn@xbsd.nl>


# Set this to the name of the XL Deploy archive that you're using
# 
ENV XLDepVer xl-deploy-4.5.2-server-free-edition


# Update and install packages
#
RUN yum -y update; yum clean all
RUN yum -y install yum install unzip java-1.7.0-openjdk.x86_64; yum clean all



# (UN)COMMENT - If you're using a TGZ archive of XL Deploy.
#
#ADD ${XLDepVer}.tgz /opt/


# (UN)COMMENT - If you're using a ZIP archive of XL Deploy (e.g., Community edition).
#               Manual unzip since Docker ADD only likes gzip/bzip2/xz archives.
#
ADD ${XLDepVer}.zip /opt/${XLDepVer}.zip
RUN cd /opt && \
    unzip ${XLDepVer}.zip && \
    rm ${XLDepVer}.zip



# Add license and setupfile
#
ADD deployit-license.lic /opt/${XLDepVer}/conf/deployit-license.lic
ADD xldeploy.setupfile /opt/${XLDepVer}/bin/xldeploy.setupfile

# Set workdir, run initial setup
#
WORKDIR /opt/${XLDepVer}/bin 
RUN ["./server.sh", "-setup", "-reinitialize", "-force", "-setup-defaults", "./bin/xldeploy.setupfile"]

EXPOSE 4516


# Volumes for data persistency
# 
VOLUME ["/opt/${XLDepVer}/conf", \
        "/opt/${XLDepVer}/ext", \
        "/opt/${XLDepVer}/hotfix", \
        "/opt/${XLDepVer}/importablePackages", \
        "/opt/${XLDepVer}/log", \
        "/opt/${XLDepVer}/plugins", \
        "/opt/${XLDepVer}/repository"]

# Fire up XL Deploy!
CMD [ "./server.sh" ]

