Container image for [Astral](https://github.com/astralapp/astral)

## Build

Use following command to build standalone docker image:

`docker build -t astral:latest .`

Use following command to build with docker-compose:

`docker-compose build`

### Configuration

### Github Client

Follow the steps below to create a github client application;

* Go to Github -> Settings -> OAuth Apps to a new OAuth app.
* Enter details for Application Name, Homepage URL, and Authorization callback URL. I.e.: Enter Astral, astral.local, and https://astral.local/auth/github/callback  respectively.
* Generate a new Client Secret.
* Create a copy of .env.template file. Modify the GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET values with your Github OAuth App's Client ID and Client Secret.

### Run

Use following command for standalone execution:

`docker run -it --rm -p 8080:80 astral:latest`

Use following command for docker-compose:

`docker-compose up -d`

### Initial Run

- Run following command to generate application key

`docker-compose exec app php artisan key:generate`

- Run following command to create/migrate database

`docker-compose exec app php artisan migrate`

# Note

You may also use prebuild [quay.io/fatihboy/astral](https://quay.io/repository/fatihboy/astral) container image.