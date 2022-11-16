This repository help operate ArgoCD service

# Prerequisites
1. [just](https://github.com/casey/just)
2. [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
3. [gcloud](https://cloud.google.com/sdk/docs/install), required if you need to set up GKE workload identity.

# Argo CD Operator Overview
For the most part we use [Argo CD's official kustomize](https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml), and added
support on our particular need. This is an overview of what's needed to be overwritten
## base
1. disable ssl in `argocd-server.yaml` as we are deploying on to GKE, which means we are setting up ingress and load balancer service on GKE,
   therefore handling certificate on GKE load balancer.
2. disable https port in `service.yaml`, same reason as above.
## overlays
1. production: configure google load balancer (frontend, backend, and ingress) in `ingress.yaml`.
2. office: office airflow is deployed on k3s, which comes with load balancer using Traefik as ingress controller, so we simply need to configure
   ingress rule in `ingress.yaml`
## workload-identity
This help set up workload identity so that argocd can deploy application to external GKE cluster. Refer to
1. [README](workload-identity/README.md) inside `workload-identity`
2. [Using Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity) official google doc.

# Quick Start
1. make sure kubectl is configured to the cluster you want to connect (i.e., the cluster you are to deploy/operate argocd),
   if its GKE then `gcloud container clusters get-credentials ${CLUSTER_NAME} --zone ${ZONE} --project ${PROJECT_ID}`
2. put your ssl certificates under `ssl/$YOUR_DOMAIN/ssl.crt` and `ssl/$YOUR_DOMAIN/ssl.key`.
3. `just setup-ssl $YOUR_DOMAIN`
4. `just setup-namespace`
5. `just deploy gke` for GKE or `just deploy k3s` for k3s
6. `just setup-plugin`
