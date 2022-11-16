This help set up workload identity so that argocd can deploy applicatioGKE's n to external GKE cluster. Refer to
1. [Using Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity) to learn about workload identity.
2. [Argo CD GKE Cluster](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#clusters) to learn about argocd with GKE cluster.

# Workflow overview
1. Enable GKE's workload identity
2. Create a Google service account
3. Grant the Google service account permission to operate on target GKE
4. Allow Argo CD's Kubernetes service accounts (`argocd-application-controller` and `argocd-server`) to
   impersonate as this Google service account

# Quick Start
1. Enable workload identity for the GKE that deploys Argo CD, refer to [official document](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity#enable).
2. Review `.env`.
3. `just create-gsa-account`, create Google service account on the project that hosts Argo CD's GKE.
4. `just grant-gsa-gke-develop-role TARGET_PROJECT_ID`
   1. This grants Google service account to deploy to TARGET_PROJECT_ID.
   2. This grants argocd service account in GKE_PROJECT ro impersonate as Google service account.
