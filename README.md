# Ethics Application System Docker Deployable
This repository contains clones of the ethic-applications-system frontend and backend repositories as a separate repository that provides a sample on how to deploy the application on Docker using docker-compose. Both repositories have been slightly modified to add `docker` directories to each cloned repo which contains the context required to install Docker.

- `frontend` is the clone of https://github.com/edwardUL99/ethics-application-system-frontend
- `backend` is the clone of https://github.com/edwardUL99/ethics-application-system-backend

This repository is only intended to be a demonstration of my Docker skills applied to a real project

## Requirements
- Docker installed on your computer (recommended to install it on Ubuntu or in an Ubuntu VM)
- docker-compose installed
- Check both cloned repositories' README's for their individual requirements

## Configuration
Before a build, the following configuration in both cloned repositories and the docker-compose file is required.

### backend
In `backend/docker/ethics` there is a file named `ethics-envs.sh`. This has a list of environment variables to be set with the exportIfNotSet function (this allows definition of environment variables in the docker-compose.yml file without the variable being overwritten). Any variables in the list can have different values set in the compose file, or else specify a default value here. Any variable pre-fixed with `DEFAULT_` needs to be added by you, as they are too sensitive to commit.

It may be easier to add configuration to the compose file since you won't have to run a build each time. See the backend's README for more configuration info.

### frontend
In `src/app/environments/environment.prod.ts`, you may need to alter the `api_base` to a URL value that can reach the backend container. The docker-compose file will need to expose the 8080 port. The configuration here is defaulted to just expose the port 8080 to 8080 on the docker host

### docker-compose.yml
Here, you can add environment variables, ports etc. to the services in the file. To add a persistent store for uploaded files to the server, create a directory, for example /home/user/fileUploads and then in docker-compose.yml backend, add the following underneath `depends_on` but the same indentation:
```yaml
volumes:
      - /home/user/fileUploads:/tmp/uploads
```
Replace the local path to a path of your chosen. Now any files uploaded to the backend server will be persisted inside here.

Also on the backend service, add an environment variable ETHICS_FRONTEND_URL to the url the frontend is hosted on to avoid CORS limitations

## Build
To build the whole docker deployable project, run the following commands:
```bash
cd backend
tools/build.sh

cd ../frontend
npm run build-docker
cd ..
```

## Run
To run the entire project and deploy the services to containers, run the following command:
```bash
docker-compose up
```

To bring it down after making a config change or a new build, run the following commnds:
```bash
# Press Ctrl-C if docker-compose is running
docker-compose down
docker-compose up
```