# Get CentOS
FROM centos:latest

# Update CentOS
RUN yum update -y

# import key from Microsoft
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc

# create yum repo file
RUN sh -c 'echo -e \
"[azure-cli]\n\
name=Azure CLI\n\
baseurl=https://packages.microsoft.com/yumrepos/azure-cli\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > \
/etc/yum.repos.d/azure-cli.repo'

# Install Azure-CLI
RUN yum -y install azure-cli

# Give root a real homedir
RUN cp /etc/skel/.bash* ~

# Prompt AZ Login each time container starts
RUN sh -c \
'echo -e \
"az login" >> ~/.bashrc'

# A place to work...
ENTRYPOINT /bin/bash