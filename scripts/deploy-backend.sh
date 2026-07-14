#!/bin/bash

set -e

echo "Deploying backend application..."

echo "Applying Kubernetes manifests..."

kubectl apply -f ../k8s/deployment.yaml
kubectl apply -f ../k8s/service.yaml
kubectl apply -f ../k8s/ingress.yaml


echo "Waiting for backend rollout..."

kubectl rollout status deployment/backend-api


echo "Backend deployment completed successfully."
