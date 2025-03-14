#!/usr/bin/env bash
set -e

# Ensure the Saved directory is owned by the steam user
chown -R steam:steam /home/steam/palworld/Pal/Saved

# check/update palworld installation
su - steam -c "/home/steam/steamcmd/steamcmd.sh +force_install_dir /palworld +login anonymous +app_update 2394010 validate +quit"

# start palworld server
su - steam -c "/home/steam/palworld/PalServer.sh ${SERVER_ARGS}"