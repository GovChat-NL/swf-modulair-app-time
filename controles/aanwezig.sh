#!/bin/sh
# Controle `aanwezig`: de app draait en de server meldt zijn vijf tools.
#   controles/aanwezig.sh [namespace]
set -eu
ns=${1:-govchat}
kubectl -n "$ns" rollout status deployment/time --timeout=180s >/dev/null
kubectl -n "$ns" port-forward service/time 18080:8080 >/dev/null 2>&1 &
pf=$!; trap 'kill $pf 2>/dev/null' EXIT; sleep 3
post() { curl -s -m 10 -D "$2" -X POST http://127.0.0.1:18080/mcp -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' ${3:+-H "Mcp-Session-Id: $3"} -d "$1"; }
hdr=$(mktemp)
post '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"controle","version":"1"}}}' "$hdr" >/dev/null
sid=$(tr -d '\r' < "$hdr" | sed -n 's/^[Mm]cp-[Ss]ession-[Ii]d: *//p')
post '{"jsonrpc":"2.0","method":"notifications/initialized"}' /dev/null "$sid" >/dev/null
tools=$(post '{"jsonrpc":"2.0","id":2,"method":"tools/list"}' /dev/null "$sid")
rm -f "$hdr"
n=$(printf '%s' "$tools" | grep -o '"name":"' | wc -l)
if [ "$n" -ge 5 ]; then echo "OK    de server meldt $n tools"; else echo "FAIL  verwacht 5 tools, kreeg $n: $tools"; exit 1; fi
