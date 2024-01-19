# docker-postgres-developer

## Configured build

Run `docker build --tag postgres-windows --build-arg WIN_VER=ltsc2022  --build-arg POSTGRES_VER=15.2-1 .`, with argument:
- WIN_VER : windows nanocore version to use ('ltsc2022' by default)
- POSTGRES_VER : postgres version to install ('15.2-1' by default)

## Default build

Run `docker build --tag postgres-windows .`

## Test

Use database login: user="dev" password=""

Run `docker run -p 5432:5432/tcp postgres-windows:latest`

