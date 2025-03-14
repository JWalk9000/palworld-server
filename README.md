# Palworld Server Docker Setup

Hey there! This is a super simple way to run your own Palworld server using Docker. No complicated setup required!

## What You Need

- Docker installed on your computer
- Docker Compose installed (usually comes with Docker)
- A little bit of disk space for the game files

## Setup Before Starting

1. Create a folder named `Saved` in the same directory as your docker-compose file
2. Make sure the `volumes` section in your `docker-compose-palworld.yml` points to this folder:
   ```
   volumes:
     - "./Saved:/home/steam/palworld/Pal/Saved"
   ```

## Quick Start

1. Open a terminal or command prompt
2. Navigate to where you saved these files
3. Run this command:

```bash
docker-compose -f docker-compose-palworld.yml up -d
```

That's it! Your server will start downloading and installing Palworld, then launch automatically.

## Where's My Game Data?

All your game saves will be in the `Saved` folder that gets created in the same directory. This means:

- Your progress won't get lost if you restart the server.
- You can back up your world by copying this folder.
- And likewise, you can import your saves and configurations from elswhere to the `Saved` folder.

## Server Settings

Want to change settings like player count or port number? Just edit the `SERVER_ARGS` line in the `docker-compose-palworld.yml` file.

The default settings are:
- Port: 8211
- Max Players: 32

For more advanced configuration, check out the official Palworld server documentation. You can use any of those startup parameters in the SERVER_ARGS environment variable in your docker-compose file.

## Starting and Stopping

- To start: `docker-compose -f docker-compose-palworld.yml up -d`
- To stop: `docker-compose -f docker-compose-palworld.yml down`
- To see logs: `docker-compose -f docker-compose-palworld.yml logs`

## Need Help?

If something's not working, try restarting the container. If that doesn't work, you might need to check if your computer meets the requirements to run a Palworld server.
