#!/bin/sh
# Run Apache Jena Fuseki for testing
set -e

VERSION="4.5.0"
URL="https://archive.apache.org/dist/jena/binaries/apache-jena-fuseki-$VERSION.tar.gz"
FUSEKI_DIR="$HOME/.fuseki"
export FUSEKI_HOME="$FUSEKI_DIR/apache-jena-fuseki-$VERSION"
export FUSEKI_BASE="$FUSEKI_HOME/run"

JAR="$FUSEKI_HOME/fuseki-server.jar"
JVM_ARGS=${JVM_ARGS:--Xmx4G}

if [ ! -e "$JAR" ]; then
    mkdir -p "$FUSEKI_DIR"
    curl -sLo "$FUSEKI_DIR/archive.tar.gz" "$URL"
    tar -C "$FUSEKI_DIR" -xvf "$FUSEKI_DIR/archive.tar.gz"
fi

DFT_LOG_CONF="$FUSEKI_HOME/log4j2.properties"
if [ -z "$LOGGING" -a -e "$DFT_LOG_CONF" ]; then
    LOGGING="-Dlog4j.configurationFile=$DFT_LOG_CONF"
fi

exec $(which java) $JVM_ARGS $LOGGING -cp "$JAR" org.apache.jena.fuseki.cmd.FusekiCmd "$@"
