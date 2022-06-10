# Pull centos from dockerhub                  -FROM
# install java                                -RUN
# create /opt/tomcat directory                -RUN
# change work directory to /opt/tomcat        -WORKDIR
# download tomcat packages                    -ADD/RUN
# extract tar.gz file                         -RUN
# Rename to tomcat directory                  -RUN
# tell to docker that it runs on port 8080    -EXPOSE
# Start tomcat services                       -CMD

FROM ubuntu:latest
# Install basic software support
RUN apt-get update && \
    apt-get install --yes software-properties-common

# Add the JDK 8 and accept licenses (mandatory)
RUN add-apt-repository ppa:webupd8team/java && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# Install Java 8
RUN apt-get update && \
    apt-get --yes --no-install-recommends install oracle-java8-installer
    
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.64/bin/apache-tomcat-9.0.64.tar.gz .
RUN tar -xvzf apache-tomcat-9.0.64.tar.gz
RUN mv apache-tomcat-9.0.64/* apache-tomcat-9.0.64
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh","run"]