apt update
apt -y install docker.io
systemctl start docker
systemctl enable docker
docker pull dustnic82/nginx-test
docker run --name nginx -p 80:80 -d dustnic82/nginx-test