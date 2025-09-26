FROM registry.redhat.io/rhel10/rhel-bootc:latest

RUN dnf install -y nginx cloud-init

RUN systemctl enable nginx
RUN systemctl enable cloud-init.target
