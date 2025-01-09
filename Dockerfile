
ARG IMAGE_NAME=ghcr.io/davidatapia/android-studio-base:main-463c548cd4f9d809b11cea4ad310b208ead92dee
FROM ${IMAGE_NAME}

ARG DEV_USER
ARG USER_ID

# Add new user identical to host $USER and add to the sudo group:
#     '--no-log-init' do not update lastlog/faillog which is problematic for large $USER_ID values 
#     '--badnames' required for first.lastname user accounts
RUN useradd -ms /usr/bin/bash --uid $USER_ID --no-log-init --badnames $DEV_USER &&\
    adduser $DEV_USER sudo

# Customize .bashrc prompt for more apparent container shell
RUN BASHRC_FILE="/home/${DEV_USER}/.bashrc" &&\
    echo $'\n'# Override prompt color to better show when attached to a running Docker container >> ${BASHRC_FILE} &&\
    echo 'PS1="\[\e]0;\u@\h: \w\a\]\[\033[01;31m\][\u@\h]\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> ${BASHRC_FILE}

# Named volumes initialized with permissions/contents of pre-existing folder; if not present, create with correct ownership
RUN mkdir -p                       /workspaces/build/ &&\
    chown -R ${USER_ID}:${USER_ID} /workspaces/build

USER $DEV_USER
