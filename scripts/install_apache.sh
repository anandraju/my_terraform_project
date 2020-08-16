#Install Nginx on EC2
#!/bin/bash
sudo su
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello world from $(hostname -f)" > /var/www/html/index.html
systemctl restart httpd
