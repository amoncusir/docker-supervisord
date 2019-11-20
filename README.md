# Base Image for use Supervisord with Docker #

Extended image from Alpine image ([See in Github](https://github.com/alpinelinux/docker-alpine)) with
[Supervisord](http://supervisord.org/) as entrypoint.

This build delegates to Docker the live-cycle of your applications using the event listener 
[Kill Supervisord](https://github.com/amoncusir/kill_supervisord).

> NOTE: Supervisord run as PID 1

## Usage

In your Dockerfile: `FROM digitalpoet/supervisord`
> See [DockerHub](https://hub.docker.com/r/digitalpoet/supervisord)

To add new configurations of Supervisord, only need copy files to folder: `/etc/supervisord/conf.d/`.
The include rule in main config file is: `/etc/supervisord/conf.d/*.conf`.

This image build use the event listener `kill_supervisord`
([See Github Repo](https://github.com/amoncusir/kill_supervisord)) with the default arguments. If you want add custom
arguments, you need to add `ENV` variable named `KILL_SUPERD_ARGS` in your dockerfile or in the os env system.

## Custom Overridable Arguments

| Name             | Default Value | Description                                       |
|------------------|---------------|---------------------------------------------------|
| LOGLEVEL         | warn          | Linked with `loglevel` supervisord config         |
| SD_LOG_MAX_SYZE  | 10MB          | Linked with `logfile_maxbytes` supervisord config |
| SD_LOG_BKP       | 0             | Linked with `logfile_backups` supervisord config  |
| KILL_SUPERD_ARGS |               | Arguments to script `kill_supervisord`            |
