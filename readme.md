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


install kubernetes

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF


sudo sysctl --system

sysctl net.ipv4.ip_forward

wget https://github.com/containerd/containerd/releases/download/v1.6.19/containerd-1.6.19-linux-amd64.tar.gz
wget https://github.com/containerd/containerd/releases/download/v1.6.32/containerd-1.6.32-linux-amd64.tar.gz

sudo tar Cxzvf /usr/local containerd-1.6.19-linux-amd64.tar.gz
sudo mkdir -p /usr/local/lib/systemd/system

wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

sudo mv containerd.service /usr/local/lib/systemd/system/containerd.service

sudo systemctl daemon-reload
sudo systemctl enable --now containerd

wget https://github.com/opencontainers/runc/releases/download/v1.1.4/runc.amd64
wget https://github.com/opencontainers/runc/releases/download/v1.1.13/runc.amd64


sudo install -m 755 runc.amd64 /usr/local/sbin/runc

wget https://github.com/containernetworking/plugins/releases/download/v1.2.0/cni-plugins-linux-amd64-v1.2.0.tgz
wget https://github.com/containernetworking/plugins/releases/download/v1.5.0/cni-plugins-linux-amd64-v1.5.0.tgz


sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.2.0.tgz 

sudo mkdir -p /etc/containerd

sudo sh -c '/usr/local/bin/containerd config default > /etc/containerd/config.toml'

sudo cat /etc/containerd/config.toml 

ps -ef | grep containerd

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/repodata/repomd.xml.key
EOF


sudo setenforce 0
sudo sed -i 's/SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo kubeadm init --cri-socket unix:///var/run/containerd/containerd.sock --pod-network-cidr=10.244.0.0/16

sudo kubeadm init --cri-socket unix:///var/run/containerd/containerd.sock





# In ubuntu 24

sudo apt update && sudo apt upgrade -y

sudo apt install -y docker.io
# echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# sudo apt update

# sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
# sudo swapoff -a

# sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo kubeadm init --pod-network-cidr=10.244.0.0/16
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket /var/run/containerd/containerd.sock --kubernetes-version <your-kubernetes-version> --image-repository registry.k8s.io --image-sandbox registry.k8s.io/pause:3.9

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket=/var/run/containerd/containerd.sock --v=5 --image-repository registry.k8s.io --image-sandbox registry.k8s.io/pause:3.9


mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubeadm join 172.31.7.114:6443 --token kc34r4.9eovuz610rz7ew68 \
	--discovery-token-ca-cert-hash sha256:c748c850566208346281d0e468a03c90eff261668b1d1b6330a68e85d4a372a5

  kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

  kubectl get nodes

  node install:

  sudo apt install containerd -y
  sudo systemctl start containerd
  sudo systemctl enable containerd

sudo systemctl status containerd

  sudo sysctl -w net.ipv4.ip_forward=1

echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

sudo kubeadm join 172.31.18.75:6443 --token gdcttt.i353q6pepg3gfl61 \
	--discovery-token-ca-cert-hash sha256:3589a8a3aa22c027356b25160b3690781681892f516dbe3bb3fe988c88cd6a96

[unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock


Fix bug proxy

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay

sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

sudo swapoff -a
containerd config default | sudo tee /etc/containerd/config.toml

sudo systemctl restart containerd

kubeadm init --cri-socket unix:///run/containerd/containerd.sock --apiserver-advertise-address 10.88.3.60 --pod-network-cidr=10.88.3.60/16

sudo systemctl status containerd
sudo systemctl restart containerd

sudo systemctl restart kubelet

192.168.10.11 kube-01.testing kube-01

sudo -i
swapoff -a
exit
strace -eopenat kubectl version

kubeadm reset
kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=192.168.211.40 --kubernetes-version=v1.18.0


kubectl -n kube-system patch ds kube-proxy -p='{
  "spec": {
    "template": {
      "spec": {
        "tolerations": [
          {
            "key": "CriticalAddonsOnly",
            "operator": "Exists"
          },
          {
            "effect": "NoSchedule",
            "key": "node-role.kubernetes.io/control-plane"
          }
        ]
      }
    }
  }
}'



ports for control panel

1. 6443 API server
2. 2379-2380 etcd
3. 10250 kubelet
4. 10259 scheduler
5. 10257 controller

wk nodes:
1. 10250 kubelet
2. 30000-32767 node port


sudo kubeadm join 172.31.26.79:6443 --token 7gch3x.50ch7lb11llw4cqa \
	--discovery-token-ca-cert-hash sha256:7660be34d74e169990e47b3420d03d4fef60517f7548dff6f16d34b824dfa4e3 

I faced the same issue, with the same symptoms, as described in this topic.
I used this Vagrantfile
In my case, the problem was with containerd settings.
I regenerate the /etc/containerd/config.toml file, and it fixes the problem.
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
also if you use Systemd cgroup driver you need to do
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
after that, you can restart the containerd service, and it should help


kubeadm join 172.31.23.81:6443 --token we8dap.siq6kija1furcg7e \
	--discovery-token-ca-cert-hash sha256:fce5d27476e63225fba25f5f21cb261564aacb3cb60bb87e9bfab5d40bf198b6 

create 
kubeadm token create --print-join-command

systemctl status containerd
sudo systemctl restart containerd
sudo systemctl restart kubelet



Release "kubernetes-dashboard" does not exist. Installing it now.
NAME: kubernetes-dashboard
LAST DEPLOYED: Mon Aug 12 01:07:43 2024
NAMESPACE: kubernetes-dashboard
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
*************************************************************************************************
*** PLEASE BE PATIENT: Kubernetes Dashboard may need a few minutes to get up and become ready ***
*************************************************************************************************

Congratulations! You have just installed Kubernetes Dashboard in your cluster.

To access Dashboard run:
  kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443

NOTE: In case port-forward command does not work, make sure that kong service name is correct.
      Check the services in Kubernetes Dashboard namespace using:
        kubectl -n kubernetes-dashboard get svc

Dashboard will be available at:
  https://localhost:8443


vi /etc/sysctl.conf 
sysctl -p
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

#vi /etc/fstab 
swapoff -a
free -m
apt update
apt install apt-transport-https ca-certificates curl jq -y
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
cat /etc/apt/sources.list.d/kubernetes.list 
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
cat /etc/apt/sources.list.d/docker.list 
apt update
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

containerd config default > /etc/containerd/config.toml
vi /etc/containerd/config.toml 
systemctl restart containerd.service 
systemctl restart containerd
systemctl status containerd
apt install kubelet kubeadm kubectl -y

kubeadm config images pull
nano kubeadm-config.yaml
ls
kubeadm init --config=kubeadm-config.yaml
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get pods -A
kubectl get nodes
systemctl status kubelet
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
kubectl get all -n kube-flannel
kubectl get pods -A
kubectl describe node ip-172-31-6-46 | grep Taints


