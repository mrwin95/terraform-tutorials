# setup jenkins

# plugins: eclipse-temurin, sonarqube scanner, gates-quatity, sonar-quailty-gate, nodejs, docker all, CloudBees

# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin

 # create eks cluster

 # ekstcl create cluster --name testbox-cluster \
 --region ap-northeast-1 \
 --node-type t2.small \
 --nodes 3 \

# Install promethious and graphana.

# curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

#helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# install: helm install stable prometheus-community/kube-prometheus-stack -n prometheus

# Edit port

kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus

change to LoadBalancer
port 9090

edit grafana
#kubectl edit svc stable-grafana -n prometheus

# get pass: kubectl get secret --namespace prometheus stable-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

install argocd

create namespace
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# install argocli

# sudo curl --slient --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.11.7/argocd-linux-amd64

# sudo chmod +x /usr/local/bin/argocd

# get argocd pass
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# kubectl get svc -n argocd