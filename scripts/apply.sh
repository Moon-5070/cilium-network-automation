#!/bin/bash
set -e

echo "[1/3] Applying apps..."
kubectl apply -f apps/

echo "[2/3] Applying policies..."
kubectl apply -f policies/

echo "[3/3] Current Cilium policies..."
kubectl get cnp -A
kubectl get ccnp
