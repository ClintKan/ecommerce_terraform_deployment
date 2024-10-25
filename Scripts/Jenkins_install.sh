echo "Updating all libs & bins....."
sudo apt update
sudo apt-get upgrade -y

# Install Java (Java 17 is required for Jenkins)
sudo apt install fontconfig openjdk-17-jre -y

# Add the Jenkins Debian repository and import the GPG key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package manager to include Jenkins packages
sudo apt update

# Install Jenkins
sudo apt install jenkins -y

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Updating all libs & bins....."
sudo apt update
sudo apt upgrade -y

# Output Jenkins initial admin password
echo "Jenkins installed successfully. You can retrieve the initial admin password using the following command:"
echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
