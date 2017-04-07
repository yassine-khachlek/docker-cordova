FROM ubuntu:16.04

MAINTAINER Yassine Khachlek <yassine.khachlek@gmail.com>

### JAVA

RUN set -x
RUN apt-get update
RUN apt-get --no-install-recommends -y install software-properties-common

## Use WebUpd8 PPA

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update

## Automatically accept the Oracle license

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections

## Install JAVA

RUN apt-get --no-install-recommends -y install oracle-java8-installer
RUN apt-get --no-install-recommends -y install oracle-java8-set-default

ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# Android SDKs

ENV ANDROID_SDK_URL="https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz"

ENV ANDROID_BUILD_TOOLS_VERSION=23.0.3

## Supported SDKs

ENV ANDROID_APIS="android-23"
ENV ANT_HOME="/usr/share/ant"
ENV MAVEN_HOME="/usr/share/maven"
ENV GRADLE_HOME="/usr/share/gradle"
ENV ANDROID_HOME="/opt/android-sdk-linux"

ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION
ENV PATH $PATH:$ANT_HOME/bin
ENV PATH $PATH:$MAVEN_HOME/bin
ENV PATH $PATH:$GRADLE_HOME/bin

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get --no-install-recommends -y install curl libstdc++6:i386 zlib1g:i386

## Installs Android SDK

RUN curl -sL ${ANDROID_SDK_URL} | tar xz -C /opt
RUN echo y | android update sdk -a -u -t platform-tools,${ANDROID_APIS},build-tools-${ANDROID_BUILD_TOOLS_VERSION}
RUN chmod a+x -R $ANDROID_HOME
RUN chown -R root:root $ANDROID_HOME

## Accept Android SDK Platforms

RUN mkdir -p "$ANDROID_HOME/licenses"
RUN echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
RUN echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license"

## Install nodejs

ENV NODEJS_VERSION=6.10.2
ENV PATH $PATH:/opt/node/bin

RUN apt-get --no-install-recommends -y install ca-certificates
RUN mkdir -p /opt/node
RUN curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 -C /opt/node
RUN ls /opt/node

RUN apt-get --no-install-recommends -y install git python

## Install build tools maven, gradle.. by creating then deleting a first project

RUN npm install -g cordova
RUN cordova create cordova-initialization-temporary-project && \
    cd cordova-initialization-temporary-project && \
    cordova platform add android && \
    cordova build && \
    cd .. && \
    rm -rf cordova-initialization-temporary-project

# Clean up

RUN npm cache clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get --auto-remove -y purge  software-properties-common && \
    apt-get autoremove -y && \
    apt-get clean
