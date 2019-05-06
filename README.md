# Java Docker images

This images are based on frolvlad/alpine-java
Which are based on Alpine Linux image, which is only a 5MB image, and contains Java runtime (JRE) and Java development kit (JDK) conveniently packaged into separate Docker tags.

JDK bundle contains lots of unnecessary for Docker image stuff, so frolvlad/alpine-java cleans it up.

yakworks/alpine-java:jdk-cleaned is the base image for others

