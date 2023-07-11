# Mixpost Pro Docker Container

This repository contains the custom Docker container for the Mixpost Pro application hosted on the GitHub Container Registry.

## Pulling the Docker Image

Pull the Docker image from the GitHub Container Registry. Please replace `<tag>` with the desired image tag.

```bash
docker pull ghcr.io/aperim/mixpost:<tag>
```

## Running the Docker Container

Once pulled, run the Docker container as follows:

```bash
docker run -d -e MIXPOST_VERSION=^0.2 -e LICENSE_EMAIL=<Your-License-Email> -e LICENSE_KEY=<Your-License-Key> -e PUID=1000 -e PGID=1000 -e APP_PORT=80 -p 80:80 --name mixpost ghcr.io/aperim/mixpost:<tag>
```

Just replace `<tag>`, `<Your-License-Email>`, and `<Your-License-Key>` with appropriate values. 

## Required Environment Variables

1. `MIXPOST_VERSION`: Specifies the version of Mixpost Pro to be installed. It should start with the `^` character (e.g., `^0.2`).

2. `LICENSE_KEY` and `LICENSE_EMAIL`: These should be acquired from the Mixpost Pro developer/vendor to use the Mixpost Pro application.

3. `PUID` and `PGID`: User ID and Group ID under which the container's process will run. If not set, these will default to `1000`.

4. `APP_PORT`: Defines the port on which the application will be running. If not set, it defaults to `80`.

5. Database-related environment variables such as `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, etc., may be required depending on your Mixpost Pro database configuration.

## Contribution

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Disclaimer

This Dockerfile and related scripts are released under the MIT license to provide an example of how to Dockerize the Mixpost Pro application, and not designed for production use.