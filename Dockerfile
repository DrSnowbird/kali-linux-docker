FROM kalilinux/kali-rolling

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

#### --- Copy Entrypoint script in the container ---- ####
COPY ./docker-entrypoint.sh /

#### ------------------------
#### ---- variables:     ----
#### ------------------------
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}
ENV USER=${USER:-developer}
ENV HOME=/home/${USER}

#### ------------------------
#### ---- user: Non-Root ----
#### (comment out the lins below if you don't like the non-root user)
#### ------------------------
## -- setup NodeJS user profile
RUN groupadd ${USER} && useradd ${USER} -m -d ${HOME} -s /bin/bash -g ${USER} && \
    ## -- Ubuntu -- \
    usermod -aG sudo ${USER} && \
    ## -- Centos -- \
    #usermod -aG wheel ${USER} && \
    echo "${USER} ALL=NOPASSWD:ALL" | tee -a /etc/sudoers && \
    echo "USER =======> ${USER}" && ls -al ${HOME}
    
#### --- Enterpoint for container ---- ####
USER ${USER}
WORKDIR ${HOME}

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/bin/bash"]
