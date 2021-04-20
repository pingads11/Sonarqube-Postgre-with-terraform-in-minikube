# Deploy Sonarqube with Terraform in Kubernetes (Minikube)
## Requirements
	 	 	 # Make Sure you have following installed
	 	 	 ########## provider.helm: version = "~> 2.1" ########
	 	 	 ########## Virtualbox                6.1     ########
	 	 	 ########## Minikube                  v1.19.0 ########
	 	 	 ########## Kubectl                   v1.21.0 ########
	 	 	 ########## Terraform                 0.12.0  ########
	 	 	 ########## Helm                      v3.5.4  ########


## What the Script will do
1. Configure Helm and Tiller for use with Kubernetes cluster;
2. Configure Nginx ingress controller;
3. Prepare Postgre DB instance;
4. Configure Sonarqube to use the DB instance provisioned in 3;
5. Install Sonarqube (should use a persistent disk volume);

## How to run
Just run **start.sh** and it will first configure and create Minikube cluster.
After creating it, it will automatically run Terraform scripts one by one.
Deploy Sonarqube ingress controller and expose url for accessing Sonarqube.

## Potential improvements

### Tiller removed in Helm version 3
Although Tiller has been removed in Helm version 3, I have deployed it too. Tested with Ubuntu 18

### No need for Nginx Ingress controller because Minikube has ingress plugin for it. (At least, setup with Minikube)
