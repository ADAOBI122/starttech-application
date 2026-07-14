# StartTech Application - Full Stack DevOps Deployment

## Overview

StartTech Application is a full-stack web application consisting of:

- A React-based frontend application
- A Golang REST API backend
- Kubernetes deployment manifests
- Automated CI/CD pipelines using GitHub Actions

The project is designed to run on Amazon Web Services using:

- Amazon EKS for Kubernetes workloads
- Amazon ECR for backend container images
- Amazon S3 and CloudFront for frontend hosting
- Amazon ElastiCache Redis for session caching
- MongoDB Atlas for persistent application data

---

# Repository Structure
starttech-application/

├── .github/
│ └── workflows/
│ ├── frontend-ci-cd.yml
│ └── backend-ci-cd.yml
│
├── frontend/
│ ├── React source code
│ ├── package.json
│ └── production build configuration
│
├── backend/
│ ├── Dockerfile
│ ├── MuchToDo/
│ │ ├── Golang REST API source
│ │ ├── internal packages
│ │ └── application configuration
│
├── k8s/
│ ├── deployment.yaml
│ ├── service.yaml
│ └── ingress.yaml
│
└── scripts/
├── deploy-frontend.sh
├── deploy-backend.sh
├── health-check.sh
└── rollback.sh


---

# Application Components

## Frontend

The frontend is built using:

- React
- TypeScript
- Vite
- Modern component-based architecture

The frontend communicates with the backend API using relative paths:
/api/v1/resource


This allows the application to work behind a unified CloudFront distribution without HTTPS mixed-content issues.

---

## Backend

The backend is developed using:

- Golang
- Gin REST framework
- MongoDB Atlas
- Redis caching

The API provides:

- Authentication
- User management
- Todo management
- Health check endpoint

Health endpoint:
GET /api/v1/health


The backend reads configuration from environment variables:
REDIS_HOST
MONGO_URI


Application logs are written to stdout for Kubernetes monitoring.

---

# Containerization

The backend application is packaged as a Docker container.

Build locally:

```bash
cd backend

docker build -t starttech-backend-api .

Run locally:
docker run -p 8080:8080 starttech-backend-api

Kubernetes Deployment

The application is deployed to Amazon EKS.

Kubernetes resources:

Deployment

File:

k8s/deployment.yaml

Features:

Rolling updates
Two replicas
Health probes
Environment variable configuration
Container port 8080
Service

File:

k8s/service.yaml

The backend is exposed internally using:

ClusterIP

Traffic is forwarded:

Service port 80
        |
        |
Container port 8080
Ingress

File:

k8s/ingress.yaml

Uses:

AWS Load Balancer Controller

Ingress class:

alb

Routes:

/api/*

to the backend service.

CI/CD Pipeline

The repository uses GitHub Actions.

Backend Pipeline

Workflow:

.github/workflows/backend-ci-cd.yml

Pipeline steps:

Checkout source code
Install Go dependencies
Run tests
go test ./...
Build Docker image
Scan image using Trivy
Authenticate with Amazon ECR
Push image with Git commit SHA tag
Update Kubernetes deployment image
Deploy to Amazon EKS
Verify rollout
Frontend Pipeline

Workflow:

.github/workflows/frontend-ci-cd.yml

Pipeline steps:

Install Node.js dependencies
npm ci
Run security audit
npm audit
Build React application
npm run build
Upload files to Amazon S3
Invalidate CloudFront cache
Deployment Scripts

The repository includes helper scripts.

Deploy Backend
./scripts/deploy-backend.sh

Actions:

Apply Kubernetes manifests
Wait for rollout completion
Deploy Frontend
./scripts/deploy-frontend.sh

Actions:

Install dependencies
Build React application
Upload build files to S3
Refresh CloudFront cache
Health Check
./scripts/health-check.sh

Checks:

Backend pods
Kubernetes service
Deployment status
Rollback
./scripts/rollback.sh

Rolls back the Kubernetes deployment to the previous version.

Required Environment Variables

Backend requires:

Variable	Description
REDIS_HOST	ElastiCache Redis endpoint
MONGO_URI	MongoDB Atlas connection string
Local Development
Frontend
cd frontend

npm install

npm run dev

Frontend runs locally using Vite development server.

Backend
cd backend/MuchToDo

go mod download

go run ./cmd/api

Backend starts the REST API service.

Production Architecture

The production flow:

User
 |
 |
CloudFront
 |
 |---------------------
 |                    |
S3 Frontend          ALB
                     |
                     |
                  Amazon EKS
                     |
                     |
              Golang Backend API
                     |
              ----------------
              |              |
          Redis Cache    MongoDB Atlas
Technologies Used
Frontend
React
TypeScript
Vite
Backend
Golang
Gin
Redis
MongoDB
DevOps
Docker
Kubernetes
Amazon EKS
Amazon ECR
Amazon S3
CloudFront
GitHub Actions


