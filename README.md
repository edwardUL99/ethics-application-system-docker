# Ethics Application System Docker Deployable
This repository contains scripts to build a docker deplotment of the ethic-applications-system using docker-compose. There are 2 directories:

- `frontend` is the deployment of https://github.com/edwardUL99/ethics-application-system-frontend
- `backend` is the deployment of https://github.com/edwardUL99/ethics-application-system-backend

This repository is only intended to be a demonstration of my Docker skills applied to a real project

## Requirements
- Docker installed on your computer (recommended to install it on Ubuntu or in an Ubuntu VM)
- docker-compose installed
- Check both cloned repositories' README's for their individual requirements
- maven 3.6.3
- npm installed globally

## Configuration
Before a build, the following configuration is required in the backend and frontend deployment directoriesand the docker-compose file is required.

### backend
In `backend` there is a file named `ethics-envs.sh`. This has a list of environment variables to be set with the exportIfNotSet function (this allows definition of environment variables in the docker-compose.yml file without the variable being overwritten). Any variables in the list can have different values set in the compose file, or else specify a default value here. Any variable pre-fixed with `DEFAULT_` needs to be added by you, as they are too sensitive to commit.

It may be easier to add configuration to the compose file since you won't have to run a build each time. See the backend's README for more configuration log.

On initial setup, there is a property `ETHICS_CHAIR_EMAIL` which determines the email of the user that should become the first chair user (which is essentially the superuser of the system)

### frontend
In `frontend/environment.prod.ts`, you may need to alter the `api_base` to a URL value that can reach the backend container. The docker-compose file will need to expose the 8080 port. The configuration here is defaulted to just expose the port 8080 to 8080 on the docker host

### docker-compose.yml
Here, you can add environment variables, ports etc. to the services in the file. To add a persistent store for uploaded files to the server, create a directory, for example /home/user/fileUploads and then in docker-compose.yml backend, add the following underneath `depends_on` but the same indentation:
```yaml
volumes:
      - /home/user/fileUploads:/tmp/uploads
```
Replace the local path to a path of your chosen. Now any files uploaded to the backend server will be persisted inside here.

Also on the backend service, add an environment variable ETHICS_FRONTEND_URL to the url the frontend is hosted on to avoid CORS limitations

In the `database` service, there is an env variable `POSTGRES_PASSWORD`. Set this variable to the password you want to use for the db and to set in `backend/ethics-envs.sh`. This is important, as if left the same as in the GitHub repository, it is not secure. Also, do not commit it

Currently the frontend can only be served on http://localhost (set in `ETHICS_FRONTEND_URL`, which needs to be set for CORS). To serve elsewhere, configure this property.

## Build
To build and deploy the whole docker deployable project, run the following command from the repository root:
```bash
./deploy.sh
```

If any directories/files already exist, you will be prompted if tou wish to delete them

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