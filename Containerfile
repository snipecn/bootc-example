FROM registry.redhat.io/rhel10/rhel-bootc:latest

RUN dnf install -y nginx cloud-init

# Enabled the root ssh login through password
COPY ./bootc.pub /root/.ssh/
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN sed -i "s/ssh_pwauth: false/ssh_pwauth: true/" /etc/cloud/cloud.cfg

# Configurate the nginx 2 vhosts
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/vhosts /etc/nginx/
COPY ./nginx/www/ /var/www
RUN chmod -R 755 /var/www

# Enable Service through reboot
RUN systemctl enable nginx
RUN systemctl enable cloud-init.target

