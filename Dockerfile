FROM openjdk:8@sha256:1911133c41c4858a1c1c9607d086e58d9cfea40fb20b0b8a987cca1c0155846e

LABEL maintainer="Atomist <docker@atomist.com>"

ENV DUMB_INIT_VERSION=1.2.2

RUN curl -s -L -O https://github.com/Yelp/dumb-init/releases/download/v$DUMB_INIT_VERSION/dumb-init_${DUMB_INIT_VERSION}_amd64.deb     && dpkg -i dumb-init_${DUMB_INIT_VERSION}_amd64.deb     && rm -f dumb-init_${DUMB_INIT_VERSION}_amd64.deb

RUN mkdir -p /app

WORKDIR /app

EXPOSE 8080

CMD ["-jar", "cd-spring-10.jar"]

ENTRYPOINT ["dumb-init", "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Xmx256m", "-Djava.security.egd=file:/dev/urandom"]

COPY target/cd-spring-10.jar cd-spring-10.jar
