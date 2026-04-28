#!/bin/bash
set -e

echo "[TEST] frontend -> backend should PASS"
kubectl exec -n frontend deploy/frontend -- curl -s --max-time 3 http://backend.backend.svc.cluster.local > /dev/null
echo "PASS"

echo "[TEST] frontend -> database should FAIL"
if kubectl exec -n frontend deploy/frontend -- curl -s --max-time 3 http://database.database.svc.cluster.local > /dev/null; then
  echo "FAIL: frontend reached database"
  exit 1
else
  echo "PASS: frontend cannot reach database"
fi

echo "[TEST] backend -> database should PASS"
kubectl run backend-client \
  --rm -i \
  --image=curlimages/curl \
  -n backend \
  --labels app=backend \
  --restart=Never \
  -- curl -s --max-time 3 http://database.database.svc.cluster.local > /dev/null
echo "PASS"
