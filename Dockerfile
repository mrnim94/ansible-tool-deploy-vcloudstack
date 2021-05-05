FROM ubuntu:16.04

RUN apt-get update -y && \
	apt-get install software-properties-common -y && \
	apt-add-repository -y ppa:ansible/ansible && \
	apt-get update -y && \
    apt-get install -y openssh-server && \
    apt-get install openssh-client -y && \
    apt install rsync -y && \
    apt install ansible -y && \
    apt install mysql-client* -y && \
    mkdir /root/.ssh

COPY ./ansible_nim/ansible-playbook/1_portal/ /usr/local/src/config_deploy_portal/deploy-sme_vstorage/
COPY ./ansible_nim/ansible-playbook/2_portal/ /usr/local/src/config_deploy_2portal/deploy-sme_vstorage/
COPY ./ssh_nim/ /root/
COPY ./ansible_nim/config/ansible.cfg /etc/ansible/

RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa.pub
RUN chmod 644 /root/.ssh/known_hosts
RUN chmod 755 /root/.ssh

RUN mkdir -p /home/auto_deploy_portal/deploy-sme_vstorage/
RUN mkdir -p /home/auto_deploy_portal/log_ansible_for_portal/

RUN mkdir -p /home/auto_deploy_2portal/deploy-sme_vstorage/
RUN mkdir -p /home/auto_deploy_2portal/log_ansible_for_portal/ 

RUN mkdir /var/run/sshd
RUN echo 'root:mrnim123' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]