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
kc create -f kubeconfig/nginx-ingress.yaml
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
kc create -f kubeconfig/testapp01.yaml 