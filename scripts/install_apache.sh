#Install Nginx on EC2
#!/bin/bash
sudo su
yum update -y
yum install -y httpd
service httpd start
chkconfig httpd on
echo "Hello world from $(hostname -f)" > /var/www/html/index.html
service httpd restart
