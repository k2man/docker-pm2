FROM centos:7
LABEL maintainer="k2mani <k2mani@gmail.com>"

# install Node
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash -
RUN yum install -y nodejs wget

# Install python, docker-ce, openssh-clients
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum install -y python docker-ce openssh-clients
RUN yum clean all -y

# Install pm2
RUN npm install -g pm2 node-gyp

# 7zip for Patch
RUN wget https://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/Packages/p/p7zip-16.02-10.el7.x86_64.rpm
RUN wget https://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/7/x86_64/Packages/p/p7zip-plugins-16.02-10.el7.x86_64.rpm
RUN rpm -U --quiet p7zip-16.02-10.el7.x86_64.rpm
RUN rpm -U --quiet p7zip-plugins-16.02-10.el7.x86_64.rpm

ENV NODE_ENV production

# EXPOSE 3000
EXPOSE 443

# change working directory
WORKDIR /app

# Start pm2.json process file
CMD ["pm2-runtime", "start", "pm2.json"]
