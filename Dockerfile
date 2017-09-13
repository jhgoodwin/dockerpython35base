FROM python:3.5

LABEL maintainer=john@jjgoodwin.com

ENV HOME /root
ENV ORACLE_HOME /usr/lib/oracle/12.1/client64

RUN apt-get update \
    && apt-get -yq install alien libaio1 \
	&& apt-get -yq autoremove \
	&& apt-get clean \
	# Install Oracle Instant Client 12 from Pennsylvania State University repository
	&& curl -O http://repo.dlt.psu.edu/RHEL5Workstation/x86_64/RPMS/oracle-instantclient12.1-basic-12.1.0.1.0-1.x86_64.rpm \
	&& curl -O http://repo.dlt.psu.edu/RHEL5Workstation/x86_64/RPMS/oracle-instantclient12.1-devel-12.1.0.1.0-1.x86_64.rpm \
	&& alien -i *.rpm \
	&& apt-get -yq purge alien \
        && apt-get -yq autoclean \
        && apt-get -yq autoremove \
        && apt-get -yq clean \
	# Setup Oracle environment
	&& echo $ORACLE_HOME/lib > /etc/ld.so.conf.d/oracle.conf \
	&& ldconfig \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& rm *.rpm
