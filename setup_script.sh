echo "####updating packages and installing docker###"
sudo apt update -y
sudo apt install wget unzip -y
sudo apt install docker.io -y

echo "####Installing jdk-17###"
sudo apt install openjdk-17-jdk -y

echo "####Installing Trivy####"
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y

echo "####Installing Tearrform###"
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt-get install terraform

echo "####Installing kubectl####"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

echo "####Installing Aws-Cli####"
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

echo "####Installing nodesjs####"
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install nodejs -y

echo "####Starting and enabling docker####"
sudo systemctl start docker 
sudo systemctl enable docker

echo "####Giving desired permissions to docker###"
sudo usermod -aG docker ubuntu
newgrp docker
sudo chmod 660 /var/run/docker.sock

echo "####Creating sonarqube container###"
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

echo "####Checking installed versions of tools####"
docker --version
trivy --version
terraform --version
kubectl version
aws --version
node -v
