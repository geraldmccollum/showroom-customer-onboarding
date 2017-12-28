FROM docker.consulting.camunda.com/customized-wildfly

# remove default example
RUN rm -rf /camunda/standalone/deployments/camunda-example-invoice-*.war
#ADD ~/.camunda/ /root/

# add showcase
ADD target/camunda-showcase-insurance-application.war /camunda/standalone/deployments/

# increase default session timeout to 8h
RUN /camunda/bin/jboss-cli.sh --commands="embed-server, /subsystem=undertow/servlet-container=default:write-attribute(name=default-session-timeout, value=480)"

EXPOSE 8787

CMD ["/camunda/bin/standalone.sh","-b","0.0.0.0","-bmanagement","0.0.0.0","--debug"]
