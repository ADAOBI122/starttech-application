#!/bin/bash

set -e


echo "Checking backend deployment health..."


kubectl get pods -l app=backend-api


echo ""
echo "Checking backend service..."


kubectl get service backend-api-service


echo ""
echo "Checking deployment status..."


kubectl rollout status deployment/backend-api --timeout=120s


echo ""
echo "Backend health check completed successfully."
