#!/bin/bash
printf '\t \t \t # Make Sure you have following installed \n'
printf '\t \t \t ########## provider.helm: version = "~> 2.1" ######## \n'
printf '\t \t \t ########## Virtualbox                6.1     ######## \n'
printf '\t \t \t ########## Minikube                  v1.19.0 ######## \n'
printf '\t \t \t ########## Kubectl                   v1.21.0 ######## \n'
printf '\t \t \t ########## Terraform                 0.12.0  ######## \n'
printf '\t \t \t ########## Helm                      v3.5.4  ######## \n'
printf '\n'
printf '\n'
printf "IF mentioned tools needed to be deployed then type yes  \n"
read -p 'Proceed with install: ' choice

if [ $choice = 'yes' ]
then
    sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"
    sudo apt update
    sudo apt install -y virtualbox-6.1 unzip
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
    sudo dpkg -i minikube_latest_amd64.deb

    curl -LO https://releases.hashicorp.com/terraform/0.12.0/terraform_0.12.0_linux_amd64.zip 
    unzip terraform_0.12.0_linux_amd64.zip
    sudo mv terraform /usr/local/bin/

    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
    helm repo add "stable" "https://charts.helm.sh/stable" --force-update

    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
else
    printf "Skipping the Basic Packages installation part \n"
fi

sudo sysctl -w vm.max_map_count=262144
minikube config set memory 8192
minikube config set cpus 4
minikube config set vm-driver virtualbox
minikube start
minikube addons enable ingress
cd terraform-kubernetes-helm
terraform init
terraform apply -auto-approve
cd ..
cd terraform-postgre
terraform init
terraform apply -auto-approve
cd ..
cd terraform-sonarqube
terraform init
terraform apply -auto-approve
cd ..
cd terraform-nginx-ingress
terraform init
terraform apply -auto-approve
cd ..
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
export KUBE_CONFIG_PATH=~/.kube/config
kubectl apply -f sonarqube-ingress.yaml
minikubeip=$(minikube ip)
echo "Sonarqube URL: https://$minikubeip/sonarqube/"

