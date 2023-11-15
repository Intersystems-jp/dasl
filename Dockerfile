ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.1.0.235.1
ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.2.0.227.0
ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2023.1.0.235.1
ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2023.2.0.227.0
FROM $IMAGE

ARG COMMIT_ID="dasl"

USER root   
        
ENV ISC_TEMP_DIR=/intersystems/iris/dasl

USER ${ISC_PACKAGE_MGRUSER}

COPY dsmdasl_demo-utf8.sav $ISC_TEMP_DIR/
COPY src/core $ISC_TEMP_DIR/core
COPY src/setup $ISC_TEMP_DIR/setup
COPY iris.script /tmp/iris.script

USER root

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /intersystems/iris/dasl

USER ${ISC_PACKAGE_MGRUSER}

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly
