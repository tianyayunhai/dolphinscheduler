#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BIN_DIR=$(dirname $0)
DOLPHINSCHEDULER_HOME=${DOLPHINSCHEDULER_HOME:-$(cd ${BIN_DIR}/../..;pwd)}
TOOLS_HOME=$(cd ${BIN_DIR}/..;pwd)

if [ "$DOCKER" != "true" ]; then
  source "$DOLPHINSCHEDULER_HOME/bin/env/dolphinscheduler_env.sh"
fi

JAVA_OPTS=${JAVA_OPTS:-"-server -Duser.timezone=${SPRING_JACKSON_TIME_ZONE} -Xms1g -Xmx1g -Xmn512m -XX:+PrintGCDetails -Xloggc:gc.log -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=dump.hprof"}

$JAVA_HOME/bin/java $JAVA_OPTS \
  -cp "$TOOLS_HOME/conf":"$TOOLS_HOME/sql":"$TOOLS_HOME/libs/*" \
  -Dspring.profiles.active=demo,${DATABASE} \
  org.apache.dolphinscheduler.tools.demo.CreateProcessDemo
