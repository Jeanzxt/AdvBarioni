#!/bin/bash
# Inicia o servidor Python do projeto BarioniSociedade (Mac/Linux)
# Use: scripts/development/start_server.sh ou bash scripts/development/start_server.sh

cd "$(dirname "$0")/../.."
exec python3 scripts/development/start_server.py "$@"
