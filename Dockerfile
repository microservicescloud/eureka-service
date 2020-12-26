FROM openjdk:8-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8761
ENTRYPOINT exec java -jar /app.jar registry


#FROM azul/zulu-openjdk-alpine:11 as packager
#
#RUN { \
#        java --version ; \
#        echo "jlink version:" && \
#        jlink --version ; \
#    }
#
#ENV JAVA_MINIMAL=/opt/jre
#
## build modules distribution
#RUN /usr/lib/jvm/zulu11/bin/jlink \
#    --verbose \
#    --add-modules \
#        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
#        # java.naming - javax/naming/NamingException
#        # java.desktop - java/beans/PropertyEditorSupport
#        # java.management - javax/management/MBeanServer
#        # java.security.jgss - org/ietf/jgss/GSSException
#        # java.instrument - java/lang/instrument/IllegalClassFormatException
#    --compress 2 \
#    --strip-debug \
#    --no-header-files \
#    --no-man-pages \
#    --output "$JAVA_MINIMAL"
#
## Second stage, add only our minimal "JRE" distr and our app
#FROM alpine
#
#ENV JAVA_MINIMAL=/opt/jre
#ENV PATH="$PATH:$JAVA_MINIMAL/bin"
#
#COPY --from=packager "$JAVA_MINIMAL" "$JAVA_MINIMAL"
#COPY "build/libs/eureka-service-1.0.0.jar" "/app.jar"
#
#EXPOSE 8080
#CMD [ "-jar", "/app.jar" ]
#ENTRYPOINT [ "java" ]