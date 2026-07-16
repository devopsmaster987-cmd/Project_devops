FROM maven:3.9-eclipse-temurin-17 AS BUILD_IMAGE
RUN apt update && git clone https://github.com/hkhcoder/vprofile-project.git
RUN cd vprofile-project && mvn install

FROM tomcat:jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE /vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]