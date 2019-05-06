FROM dock9/oraclejdk8:python

ENV GRADLE_VERSION=3.5.1
ENV GRADLE_HOME=$SDKMAN_DIR/candidates/gradle/current
ENV PATH=$GRADLE_HOME/bin:$PATH

RUN /bin/bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh; \
sdk install gradle $GRADLE_VERSION; \
sdk flush archives; \
sdk flush temp "

# smoke test
RUN gradle -version

# install mysql-client on this one so we can dump databases
RUN apk add --no-cache \
    mysql-client && \
    rm -rf /var/cache/apk/*

#Install Gradle Version: 3.5 manually, here for reference
# RUN curl --silent --show-error --location --fail --retry 3 --output /tmp/gradle.zip \
#    https://services.gradle.org/distributions/gradle-3.5-bin.zip \
#    && unzip -d /opt /tmp/gradle.zip \
#    && rm /tmp/gradle.zip \
#    && ln -s /opt/gradle-* /opt/gradle \
#    && /opt/gradle/bin/gradle -version

