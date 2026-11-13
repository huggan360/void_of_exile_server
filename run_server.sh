#!/bin/sh
# Runs the Void of Exile dedicated server from this folder (a release build:
# VoidOfExileServer.x86_64 and VoidOfExileServer.pck next to this script).
#   ./run_server.sh [--config=/path/to/config] [--port=24565] [--name="My Realm"]
# The config folder defaults to ./config (server.cfg is written on first start;
# put your server key in it, see README.md).
HERE="$(cd "$(dirname "$0")" && pwd)"
case " $* " in *" --config="*) ;; *) set -- "--config=$HERE/config" "$@" ;; esac
exec "$HERE/VoidOfExileServer.x86_64" --headless -- --dedicated "$@"
