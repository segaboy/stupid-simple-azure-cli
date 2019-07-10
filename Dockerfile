# Get CentOS
FROM centos:latest

# Update CentOS
RUN yum update -y

# import key from Microsoft
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc

# create yum repo file
RUN sh -c 'echo -e \
"[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/a\
zure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/mic\
rosoft.asc" > /etc/yum.repos.d/azure-cli.repo'

# Install Azure-CLI
RUN yum -y install azure-cli

# Give root a real homedir
RUN cp /etc/skel/.bash* ~

# Prompt AZ Login each time container starts
RUN sh -c \
'echo -e \
"PS1="simple azure cli : \naz login\n"" >> ~/.bashrc'

# A place to work...
ENTRYPOINT /bin/bash