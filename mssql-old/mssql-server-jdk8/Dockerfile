FROM microsoft/mssql-server-linux:2017-latest

# ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-amd64"

# RUN apt-get update && \
#     apt-get -y install openjdk-8-jdk && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# adds some files for testing, fontconfig ttf-dejavu are needed for jasper testing 
# might need to add xvfb
RUN apt-get update && \ 
    apt-get -y install make unzip git mysql-client fontconfig ttf-dejavu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# the JAVA_BUILD and JAVA_PATH are legacy from fovld's before orcale took the download down
ENV JAVA_VERSION=8 \
    JAVA_UPDATE=211 \
    JAVA_BUILD=08 \
    JAVA_PATH=1961070e4c9b4e26a04e7f5a083f551e \
    JAVA_HOME="/usr/lib/jvm/default-jvm"

# COPY jdk-8u211-linux-x64.tar.gz /tmp

# RUN cd "/tmp" && \
#     wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
#         "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
#     tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \

RUN cd "/tmp" && \
    wget "https://www.dropbox.com/s/pqylw07fokfm7io/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz?dl=1" && \
    tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz?dl=1" && \
    mkdir -p "/usr/lib/jvm" && \
    mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" && \
    ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    rm -rf "$JAVA_HOME/"*src.zip && \
    rm -rf "$JAVA_HOME/lib/missioncontrol" \
           "$JAVA_HOME/lib/visualvm" \
           "$JAVA_HOME/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/plugin.jar" \
           "$JAVA_HOME/jre/lib/ext/jfxrt.jar" \
           "$JAVA_HOME/jre/bin/javaws" \
           "$JAVA_HOME/jre/lib/javaws.jar" \
           "$JAVA_HOME/jre/lib/desktop" \
           "$JAVA_HOME/jre/plugin" \
           "$JAVA_HOME/jre/lib/"deploy* \
           "$JAVA_HOME/jre/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/"*jfx* \
           "$JAVA_HOME/jre/lib/amd64/libdecora_sse.so" \
           "$JAVA_HOME/jre/lib/amd64/"libprism_*.so \
           "$JAVA_HOME/jre/lib/amd64/libfxplugins.so" \
           "$JAVA_HOME/jre/lib/amd64/libglass.so" \
           "$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so" \
           "$JAVA_HOME/jre/lib/amd64/"libjavafx*.so \
           "$JAVA_HOME/jre/lib/amd64/"libjfx*.so && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION}/jce_policy-${JAVA_VERSION}.zip" && \
    unzip -jo -d "${JAVA_HOME}/jre/lib/security" "jce_policy-${JAVA_VERSION}.zip" && \
    rm "${JAVA_HOME}/jre/lib/security/README.txt" && \
    rm "/tmp/"* && \
    \
    echo 'public class Main { public static void main(String[] args) { System.out.println("Java code is running fine!"); } }' > Main.java && \
    javac Main.java && \
    java Main && \
    rm -r "/tmp/"*

RUN javac -version; \
    java -version

WORKDIR /project

