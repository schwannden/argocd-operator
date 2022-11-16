# print help message
default:
	@just -l


# create namespace
setup-namespace:
	kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

# create kustomize + helm plugin
setup-plugin:
	kubectl apply -n argocd -f helm-plugin.yaml

# setup ssl for argo server
setup-ssl domain:
  kubectl create -n argocd secret tls argocd-server-tls \
    --cert=.ssl/{{domain}}/ssl.crt \
    --key=.ssl/{{domain}}/ssl.key

# install kustomize
download-kustomize:
	curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
	sudo chmod +x kustomize
	sudo mv kustomize /usr/local/bin

## deploy argo
deploy env:
	kubectl apply -n argocd -k overlays/{{env}}

## stop argo
stop env:
	kubectl delete -n argocd -k overlays/{{env}}

