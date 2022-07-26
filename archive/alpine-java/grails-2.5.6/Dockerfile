FROM yakworks/alpine-java:jdk8-builder

ENV GRAILS_VERSION=2.5.6
# ENV PATH=$GRAILS_HOME/bin:$PATH
# ENV SDKMAN_DIR /sdkman
# ENV GRAILS_HOME=$SDKMAN_DIR/candidates/grails/current

# RUN /bin/bash -c "curl -s 'https://get.sdkman.io' | bash; \
# source /sdkman/bin/sdkman-init.sh; \
# sed -i -e 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g' /sdkman/etc/config;"

# RUN /bin/bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh; \
# sdk install grails $GRAILS_VERSION; \
# sdk flush archives; \
# sdk flush temp "


# manual way here for refernce in case sdkman acts up
WORKDIR /opt/grails
RUN wget https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
    unzip grails-$GRAILS_VERSION.zip && \
    rm -rf grails-$GRAILS_VERSION.zip && \
    ln -s grails-$GRAILS_VERSION current

# Setup Grails path.
ENV GRAILS_HOME=/opt/grails/current
ENV PATH="$GRAILS_HOME/bin:$PATH"

# smoke test and install default dependencies
RUN grails create-app foo \
	&& cd foo \
	&& grails compile \
	&& cd .. \
	&& rm -rf foo

WORKDIR /opt/jfrog
RUN curl -XGET https://api.bintray.com/content/jfrog/jfrog-cli-go/1.38.0/jfrog-cli-linux-386/jfrog?bt_package=jfrog-cli-linux-386 -L -k > jfrog && \
    chmod u+x jfrog
ENV PATH="/opt/jfrog:$PATH"

WORKDIR /project