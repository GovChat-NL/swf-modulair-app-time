#!/bin/sh
# Controle `afwezig`: zonder de app draait er niets van.
#   controles/afwezig.sh [namespace]
set -eu
ns=${1:-govchat}
failed=0
rest=$(kubectl -n "$ns" get deploy,svc,netpol,cronjob,cm,secret,pvc -l govchat.app=time -o name)
if [ -z "$rest" ]; then echo "OK    geen onderdelen met het label govchat.app=time"; else echo "FAIL  nog aanwezig: $rest"; failed=1; fi
config=$(kubectl -n "$ns" get configmap -o yaml | grep -c 'time:8080' || true)
if [ "$config" = "0" ]; then echo "OK    de configuratie van LibreChat noemt de app niet"; else echo "FAIL  de configuratie van LibreChat noemt de app nog"; failed=1; fi
exit $failed
