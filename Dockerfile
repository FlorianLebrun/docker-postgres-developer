ARG WIN_VER=ltsc2019
ARG POSTGRES_VER=15.2-1

#######################################
#### Prepare PostgreSQL for Windows
#######################################
FROM mcr.microsoft.com/windows/servercore:${WIN_VER} as prepare
ARG POSTGRES_VER
ENV POSTGRES_VER $POSTGRES_VER
SHELL ["powershell", "-Command"]

COPY scripts/1.prepare-setup.ps1 /
RUN  c:/1.prepare-setup.ps1 -InstallDir "c:/" -PostgresVersion "$env:POSTGRES_VER"

COPY scripts/2.prepare-vcredist.ps1 /
RUN  c:/2.prepare-vcredist.ps1 -InstallDir "c:/" -PostgresVersion "$env:POSTGRES_VER"

COPY scripts/3.prepare-config.ps1 /
RUN  c:/3.prepare-config.ps1 -InstallDir "c:/" -PostgresVersion "$env:POSTGRES_VER"

#######################################
#### Make PostgreSQL for Windows 
#######################################
FROM mcr.microsoft.com/windows/servercore:${WIN_VER}

# Setup postgres
COPY --from=prepare /pgsql /pgsql
COPY scripts/entrypoint.ps1 /
USER ContainerAdministrator
RUN setx /M PATH "c:/pgsql/bin;%PATH%"
USER ContainerUser

EXPOSE 5432
CMD ["powershell.exe", "-Command", "c:/entrypoint.ps1"]
