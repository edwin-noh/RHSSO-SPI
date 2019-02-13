FROM registry.access.redhat.com/redhat-sso-7/sso72-openshift:1.3
MAINTAINER Edwin Noh

# Temporarily elevate permissions
USER root
RUN rm -f /opt/eap/standalone/configuration/standalone-openshift.xml
#RUN rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history
# Copy JAR & set right permissions
ADD db-user-storage-sample.jar /opt/eap/standalone/deployments/db-user-storage-sample.jar
ADD core-integration-user-sample.jar /opt/eap/standalone/deployments/core-integration-user-sample.jar
ADD com /opt/eap/modules/com
ADD standalone-openshift.xml /opt/eap/standalone/configuration/standalone-openshift.xml 
RUN cd /opt/eap/standalone/deployments && \
chown jboss:jboss db-user-storage-sample.jar && \
chmod 664 db-user-storage-sample.jar && \
chown jboss:jboss core-integration-user-sample.jar && \
chmod 664 core-integration-user-sample.jar && \
cd /opt/eap/standalone/configuration && \
chown jboss:jboss standalone-openshift.xml && \
chmod 664 standalone-openshift.xml && \
cd /opt/eap/modules && \
chown -R jboss:jboss com && \
chmod -R 775 com

# Drop permissions
USER jboss
