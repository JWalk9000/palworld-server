# Base image: Ubuntu 24.04
FROM ubuntu:24.04

# Set non-interactive mode for installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    apt-utils \
    passwd \
    curl \
    wget \
    tar \
    software-properties-common \
    lib32gcc-s1

# Add steam user and add to sudo group
RUN adduser --disabled-password --gecos "" steam && adduser steam sudo

# Install SteamCMD dependencies
WORKDIR /home/steam
USER steam
RUN mkdir /home/steam/steamcmd && \
    cd steamcmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

RUN chmod +x /home/steam/steamcmd/steamcmd.sh
#RUN chown -R steam:steam /home/steam/steamcmd

# Install PalWorld game server
WORKDIR /home/steam
RUN mkdir /home/steam/palworld
RUN exec /home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/palworld +login anonymous +app_update 2394010 validate +quit

# Switch to root user
USER root

# Create a volume for game saves and configurations
VOLUME /home/steam/palworld/Pal/Saved

# Change ownership of the PalWorld directory
RUN chown -R steam:steam /home/steam/palworld

# Set environment variables for server launch arguments
ENV SERVER_ARGS=""

# Expose port 8211
EXPOSE 8211/udp

# Copy entrypoint script
COPY entrypoint.sh /home/steam/entrypoint.sh
RUN chmod +x /home/steam/entrypoint.sh && \
    chown steam:steam entrypoint.sh

# Entrypoint to start the server
USER root
WORKDIR /home/steam/palworld
ENTRYPOINT ["/home/steam/entrypoint.sh"]
CMD ["$SERVER_ARGS"]