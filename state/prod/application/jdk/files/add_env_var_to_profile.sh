#!/bin/bash

if grep '# Set Java Environment Variable' /etc/profile > /dev/null 2>&1;
then
    exit 0
else
    cat >> /etc/profile << EOF

# Set Java Environment Variable
export JAVA_HOME="/usr/local/services/jdk"
export PATH=\$JAVA_HOME/bin:$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
fi
