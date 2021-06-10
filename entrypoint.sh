#!/bin/sh
# Docker entrypoint script.

/app/bin/wave eval "Wave.Release.migrate"

exec $@
