#!/bin/bash

set -e


echo "Starting backend rollback..."


kubectl rollout undo deployment/backend-api


echo "Waiting for rollback to complete..."


kubectl rollout status deployment/backend-api --timeout=120s


echo "Rollback completed successfully."
