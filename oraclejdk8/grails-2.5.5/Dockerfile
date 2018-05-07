FROM dock9/oraclejdk8:python

# install mysql-client on this one so we can dump databases
RUN apk add --no-cache \
    mysql-client && \
    rm -rf /var/cache/apk/*

ENV GRAILS_VERSION=2.5.4
ENV GRAILS_HOME=$SDKMAN_DIR/candidates/grails/current
ENV PATH=$GRAILS_HOME/bin:$PATH

RUN /bin/bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh; \
sdk install grails $GRAILS_VERSION; \
sdk flush archives; \
sdk flush temp "

# smoke test to install default deps
RUN grails create-app foo254 \
	&& cd foo254 \
	&& grails compile \
	&& cd .. \
	&& rm -rf foo254


ENV GRAILS_VERSION=2.5.5

RUN /bin/bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh; \
sdk install grails $GRAILS_VERSION; \
sdk flush archives; \
sdk flush temp "

# smoke test to install default deps
RUN grails create-app foo255 \
	&& cd foo255 \
	&& grails compile \
	&& cd .. \
	&& rm -rf foo255

# manual way here for refernce in case sdkman acts up
# WORKDIR /opt/grails
# RUN wget https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
#     unzip grails-$GRAILS_VERSION.zip && \
#     rm -rf grails-$GRAILS_VERSION.zip && \
#     ln -s grails-$GRAILS_VERSION current

# # Setup Grails path.
# ENV GRAILS_HOME=/opt/grails/current
# ENV PATH="$GRAILS_HOME/bin:$PATH"
