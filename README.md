# TrailRunner

Produce statistics over an area hiked multiple times

## GHCR login

You must login to the Github Container Registry (GHCR) before starting up the TrailRunner builder environment for the first time.  Start that by [creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token) having at least "read" package repository priviledges.  Optionally, add "write" package repository priviledges to your token to have the ability to rollback the active base image, if things should go wrong.  Then login to GHCR with your token:
```
echo <PersonnelAccessToken> | docker login ghcr.io -u <Github-Username> --password-stdin
```

## Starting the TrailRunner builder environment

First-time startup will build your local docker image by pulling the base image `ghcr.io/davidatapia/trailrunner:latest` [from GHCR](https://github.com/DavidATapia/trailrunner/pkgs/container/trailrunner) and customizing it around your host username.

To build the local image and launch the container, type:
```
./up.sh
```

Then (in a different shell) attach to your container with:
```
docker exec -it trailrunner-dev-env bash
```

The red command prompt serves as a visual cue that you're in a container shell -- not the host shell.

To rebuild your local image whenever the base image changes, type:
```
./up.sh -r
```

## Building the application in the TrailRunner container

> [!IMPORTANT]
> Though the build is performed within the container environment, the user's local 'trailrunner-builder' folder is mapped into the container as part of the container workspace. Ensure that any host-only build environments are kept separate from those running in the container.

All application building is done in the container.  Once attached to the container, invoke the ------ to be built:
```
<BUILD COMMAND HERE!>
```

## Side-loading the app to the Pixel 6

```
cd /workspaces/
```
