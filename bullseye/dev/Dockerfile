ARG REGISTRY=yakworks
FROM $REGISTRY/bullseye:jdk11

ENV TERM=xterm-256color
# misc editors and ranger file manager
RUN apt-get -y update && apt-get -y --no-install-recommends install \
    file \
    ranger \
    nano \
    joe \
    vim \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# install bash-it
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  ~/.bash_it/install.sh --silent

# gw gradle shortcut needs to come before the bashit load
RUN sed -i.x -E 's|# Load Bash It|alias gw="./gradlew"|g' /root/.bashrc \
  && sed -i.x 's|bobby|powerline|g' /root/.bashrc

SHELL ["/bin/bash", "-c"]

# RUN source /root/.bash_it/bash_it.sh && shit enable completion gradle
RUN source /root/.bash_it/bash_it.sh \
    && bash-it enable completion gradle

# ranger file manager config
RUN ranger --copy-config=all && \
  sed -i.x 's|show_hidden false|show_hidden true|g' /root/.config/ranger/rc.conf

COPY complete_alias /root/

RUN echo "source /usr/share/bash-completion/bash_completion" >> /root/.bashrc && \
    echo "alias ll='ls -lahG'" >> /root/.bashrc && \
    echo "alias gw='./gradlew'" >> /root/.bashrc && \
    echo "alias m='make'" >> /root/.bashrc && \
    echo "source $HOME/complete_alias" >> /root/.bashrc && \
    echo "complete -F _complete_alias m" >> /root/.bashrc
