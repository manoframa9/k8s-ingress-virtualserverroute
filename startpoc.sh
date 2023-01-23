cat <<EOF | kind create cluster  --name pocvsr --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF
sleep 2
kind get clusters
echo "=========================================================="
kubectl cluster-info --context kind-pocvsr
echo "=========================================================="
# echo "======= create ingress controller ========================"
# kc create -f kubeconfig/nginx-ingress.yaml
# kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
# kc create -f kubeconfig/testapp01.yaml 
# kc create -f kubeconfig/testapp02.yaml 
#####################################################################
# kubectl apply -f common/ns-and-sa.yaml
# kubectl apply -f rbac/rbac.yaml
# kubectl apply -f common/default-server-secret.yaml
# kubectl apply -f common/nginx-config.yaml
# kubectl apply -f common/ingress-class.yaml
# kubectl apply -f common/crds/k8s.nginx.org_virtualservers.yaml
# kubectl apply -f common/crds/k8s.nginx.org_virtualserverroutes.yaml
# kubectl apply -f common/crds/k8s.nginx.org_transportservers.yaml
# kubectl apply -f common/crds/k8s.nginx.org_policies.yaml
# kubectl apply -f common/crds/k8s.nginx.org_globalconfigurations.yaml
# kubectl apply -f daemon-set/nginx-ingress.yaml
###### >> for real use #####  kubectl apply -f service/loadbalancer.yaml
# kubectl create -f service/nodeport.yaml