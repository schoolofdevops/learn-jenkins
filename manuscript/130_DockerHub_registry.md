# Create a custom Tomcat image with our application

## Create the Docker job

* Create a freestyle project with the name Docker(or whatever name you wish).
* Give a description and Add **Deploy** project as build trigger.
* You can skip other steps in between.
* In Build(Add build step), select **Execute shell**.

![Build](images/dockerhub/Build.jpg)
* Paste the following script in the text box.

```#!/bin/bash

#Change these values
jobname=Deploy
jenkinsurl=192.168.0.62:8080
appname=CMADSession
version=0.0.12-\SNAPSHOT
context=cmad
custom=customtom

#Remove Existing residue files
rm -rf $JENKINS_HOME/Docker

#Prepare the environment
mkdir $JENKINS_HOME/Docker && \
    cd $JENKINS_HOME/Docker && \
wget http://$jenkinsurl/job/$jobname/lastSuccessfulBuild/$appname\$$appname/artifact/$appname/$appname/$version/$appname-$version.war && \
mv $appname-$version.war $context.war

#Create Dockerfile
cat <<EOT>> Dockerfile

FROM openjdk:8-jre-alpine

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH \$CATALINA_HOME/bin:\$PATH
RUN mkdir -p "\$CATALINA_HOME"
WORKDIR \$CATALINA_HOME

# let "Tomcat Native" live somewhere isolated
ENV TOMCAT_NATIVE_LIBDIR \$CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH \${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}\$TOMCAT_NATIVE_LIBDIR

RUN apk add --no-cache gnupg

# see https://www.apache.org/dist/tomcat/tomcat-\$TOMCAT_MAJOR/KEYS
# see also "update.sh" (https://github.com/docker-library/tomcat/blob/master/update.sh)
ENV GPG_KEYS 05AB33110949707C93A279E3D3EFE6B686867BA6 07E48665A34DCAFAE522E5E6266191C37C037D42 47309207D818FFD8DCD3F83F1931D684307A10A5 541FBE7D8F78B25E055DDEE13C370389288584E7 61B832AC2F1C5A90F0F9B00A1C506407564C17A3 79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED 9BA44C2621385CB966EBA586F72C284D731FABEE A27677289986DB50844682F8ACB77FC2E86E29AC A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23
RUN set -ex; \
	for key in \$GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "\$key"; \
	done

ENV TOMCAT_MAJOR 9
ENV TOMCAT_VERSION 9.0.0.M17

# https://issues.apache.org/jira/browse/INFRA-8753?focusedCommentId=14735394#comment-14735394
ENV TOMCAT_TGZ_URL https://www.apache.org/dyn/closer.cgi?action=download&filename=tomcat/tomcat-\$TOMCAT_MAJOR/v\$TOMCAT_VERSION/bin/apache-tomcat-\$TOMCAT_VERSION.tar.gz
# not all the mirrors actually carry the .asc files :'(
ENV TOMCAT_ASC_URL https://www.apache.org/dist/tomcat/tomcat-\$TOMCAT_MAJOR/v\$TOMCAT_VERSION/bin/apache-tomcat-\$TOMCAT_VERSION.tar.gz.asc

RUN set -x \
	\
	&& apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		tar \
		openssl \
	&& wget -O tomcat.tar.gz "\$TOMCAT_TGZ_URL" \
	&& wget -O tomcat.tar.gz.asc "\$TOMCAT_ASC_URL" \
	&& gpg --batch --verify tomcat.tar.gz.asc tomcat.tar.gz \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomcat.tar.gz* \
	\
	&& nativeBuildDir="\$(mktemp -d)" \
	&& tar -xvf bin/tomcat-native.tar.gz -C "\$nativeBuildDir" --strip-components=1 \
	&& apk add --no-cache --virtual .native-build-deps \
		apr-dev \
		gcc \
		libc-dev \
		make \
		"openjdk\${JAVA_VERSION%%[-~bu]*}"="\$JAVA_ALPINE_VERSION" \
		openssl-dev \
	&& ( \
		\export CATALINA_HOME="\$PWD" \
		&& cd "\$nativeBuildDir/native" \
		&& ./configure \
			--libdir="\$TOMCAT_NATIVE_LIBDIR" \
			--prefix="\$CATALINA_HOME" \
			--with-apr="\$(which apr-1-config)" \
			--with-java-home="\$(docker-java-home)" \
			--with-ssl=yes \
		&& make -j\$(getconf _NPROCESSORS_ONLN) \
		&& make install \
	) \
	&& runDeps="\$( \
		scanelf --needed --nobanner --recursive "\$TOMCAT_NATIVE_LIBDIR" \
			| awk '{ gsub(/,/, "\nso:", \$2); print "so:" \$2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)" \
	&& apk add --virtual .tomcat-native-rundeps \$runDeps \
	&& apk del .fetch-deps .native-build-deps \
	&& rm -rf "\$nativeBuildDir" \
	&& rm bin/tomcat-native.tar.gz

# verify Tomcat Native is working properly
RUN set -e \
	&& nativeLines="\$(catalina.sh configtest 2>&1)" \
	&& nativeLines="\$(echo "\$nativeLines" | grep 'Apache Tomcat Native')" \
	&& nativeLines="\$(echo "\$nativeLines" | sort -u)" \
	&& if ! echo "\$nativeLines" | grep 'INFO: Loaded APR based Apache Tomcat Native library' >&2; then \
		echo >&2 "\$nativeLines"; \
		exit 1; \
	fi

ADD cmad.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
EOT

#Create cutom tomcat image
docker build -t $custom .
```
* Replace the default variable values with your respective values.
* This script will build an custom Tomcat image with your application
* Run *docker images* to see if your image is in your machine or not.

```
REPOSITORY                                TAG                 IMAGE ID            CREATED             SIZE
customtom                                 latest              73af4f86b295        40 minutes ago      355 MB
schoolofdevops/jenkins-2.19.4-alpine      latest              ce303bab6505        2 days ago          340 MB
tomcat                                    latest              c822d296d232        2 days ago          355 MB
sonarqube                                 5.6.4               5b9898c62a2f        10 days ago         778 MB
docker.bintray.io/jfrog/artifactory-oss   latest              d7d26a1a4a8e        11 days ago         448 MB
```

## Push Your Image

* Go to [Docker Hub](https://hub.docker.com/).

* Sign up if you don't have an account or log in.

![login](images/dockerhub/login.jpg)

* After logging in, you will be presented with the following screen. I already have two repositories created, that's why we see them. In your case, you will not see any repository listed.

![dashboard](images/dockerhub/dashboard.jpg)

* Now we will push this image to Docker Hub.
* Log in to your **Docker Hub** from the machine

![login_console](images/dockerhub/login_console.jpg)

* Now in the machine in which you have the custom image, tag the **Image ID** with your **Docker Hub** name

```
docker tag ImageID YourDockerHubId/ImageName:latest
```

![tag](images/dockerhub/tag.jpg)

* Now to push the image to Docker Hub, run the following command

```
docker push YourDockerHubId/ImageName:latest
```

![push](images/dockerhub/push.jpg)

* After pushing the image, you can see it is listed on your Docker Hub dashboard.

![repo](images/dockerhub/repo.jpg)

* Now you can pull this image from any machine just like pulling other docker images. Only thing that you have to have in your mind is specifying correct repository name in the pull command.

```
docker pull YourRepoName/YourImageName:
```

![pull](images/dockerhub/pull.jpg)

-----

:point_left:[**Prev** Chapter 12: Deploying to Tomcat Job](https://github.com/schoolofdevops/learn-jenkins/blob/master/manuscript/120_deploy_to_tomcat.md)
:point_right:[**Prev** Chapter 14: Deploy application to a Docker Swarm cluster](https://github.com/schoolofdevops/learn-jenkins/blob/master/manuscript/140_deploy_application_to_docker_swarm_cluster.md)
