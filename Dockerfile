FROM frolvlad/alpine-oraclejdk8:slim

MAINTAINER Scott Fan <fancp2007@gmail.com>

ENV MAVEN_VERSION 3.3.9

RUN apk upgrade --update && \
    apk add --update curl unzip tar && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/unlimited_jce_policy.zip "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" && \
    unzip -jo -d ${JAVA_HOME}/jre/lib/security /tmp/unlimited_jce_policy.zip && \
    mkdir -p /usr/share/maven && \
    curl -fsSL https://repo1.maven.org/maven2/org/apache/maven/apache-maven/$MAVEN_VERSION/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzC /usr/share/maven --strip-components=1 && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    apk del curl unzip tar && \
    rm -rf /tmp/* /var/cache/apk/*

ENV MAVEN_HOME /usr/share/maven

VOLUME /root/.m2

CMD ["mvn"]
