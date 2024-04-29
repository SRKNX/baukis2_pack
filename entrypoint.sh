#!/bin/bash

set -e
#Removeapotentiallypreexistingserver.pidforRails.

rm -f /baukis2_myapp/tmp/pids/server.pid
#Thenexecthecontainer'smainprocess(what'ssetasCMDintheDockerfile).

exec "$@"
