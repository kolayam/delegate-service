FROM maven:3.8.6-jdk-8
WORKDIR /usr/src/app
COPY . .
RUN ls .
RUN mvn clean install -Dmaven.test.skip=true

FROM tomcat
MAINTAINER nirro@il.ibm.com

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=0 /usr/src/app/target/delegate-service.war /usr/local/tomcat/webapps/ROOT.war
COPY --from=0 /usr/src/app/WEB-INF/web.xml /usr/local/tomcat/conf/web.xml
# ADD ./target/delegate-service.war /usr/local/tomcat/webapps/ROOT.war
# COPY ./WEB-INF/web.xml /usr/local/tomcat/conf/web.xml

#ENV eureka.environment dev
CMD ["catalina.sh", "run"]
