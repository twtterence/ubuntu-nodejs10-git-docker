
FROM twtterence/ubuntu-nodejs10-git:latest
LABEL maintainer="twtterence@gmail.com"

SHELL ["/bin/bash","-c"] 

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"
    
RUN apt-get update; \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common; \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -; \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"; \
    apt-get update; \
    apt-get install -y docker-ce; \
    apt-get clean; \
    usermod -aG docker jenkins;

WORKDIR /root/build

CMD ["bash"]
