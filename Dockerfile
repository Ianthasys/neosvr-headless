FROM    steamcmd/steamcmd:ubuntu-22

# Setup initial environment.
RUN     apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y mono-devel
#        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
#        echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
#        apt-get update \
#        apt-get install -y mono-devel

# Build Arguments
ARG     STEAMBETA="headless-client" \
        STEAMAPPID="740250" \
        STEAMAPPDIR="/usr/games/neosvr-headless" \
        STEAMBETAPASS="" \
        STEAMLOGIN="" \
        STEAMPASS="" 

# These ENV variables will be specified in docker-compose.yml
ENV     CLEANLOGS=true \
        CLEANASSETS=true \
        LOGSCLEANUPFREQ=30 \
        ASSETCLEANUPFREQ=7 \
        NML=false

# Install NeosVR Headless server.
RUN     steamcmd +force_install_dir ${STEAMAPPDIR} +login ${STEAMLOGIN} ${STEAMPASS} +app_update ${STEAMAPPID} -beta headless-client -betappassword ${BETAPASSWORD} +quit
WORKDIR ${STEAMAPPDIR}
RUN     mkdir -p Config Logs Libraries nml_mods nml_libs

CMD     mono Neos.exe
