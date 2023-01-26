FROM    steamcmd/steamcmd:ubuntu-22

# Setup initial environment.
RUN     apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y mono-devel

# Build Arguments
ARG     STEAMBETA="headless-client" \
        STEAMAPPID="740250" \
        STEAMAPPDIR="/usr/games/neosvr-headless" \
        STEAMBETAPASS="" \
        STEAMLOGIN="" \
        STEAMPASS="" 

# These ENV variables will be specified in docker-compose.yml
#ENV     CLEANLOGS=true \
#        CLEANASSETS=true \
#        LOGSCLEANUPFREQ=30 \
#        ASSETCLEANUPFREQ=7 \
#        NML=false

# Install NeosVR Headless server.
RUN     steamcmd +force_install_dir ${STEAMAPPDIR} +login ${STEAMLOGIN} ${STEAMPASS} +app_update ${STEAMAPPID} -beta headless-client -betappassword ${BETAPASSWORD} +quit
WORKDIR ${STEAMAPPDIR}
RUN     mkdir -p Config Logs Libraries nml_mods nml_libs Scripts

STOPSIGNAL SIGINT

ENTRYPOINT ["/Scripts/start_neosvr.sh"]