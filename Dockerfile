FROM eclipse-temurin:22-alpine AS jre-build

RUN $JAVA_HOME/bin/jlink \
    --add-modules java.base,java.logging,java.desktop,java.sql,java.management,java.compiler,jdk.zipfs \ 
    --strip-debug \ 
    --no-man-pages \ 
    --no-header-files \
    --compress=2 \
    --output /jre 

FROM alpine:latest

WORKDIR /minecraft

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY --from=jre-build /jre ${JAVA_HOME}

ENTRYPOINT ["sh"]
