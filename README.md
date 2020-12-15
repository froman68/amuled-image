# amuled-image

Docker file to start amule daemon based on Ubuntu 20.10 (groovy), as it is not in repositories of Ubuntu 20.04 LTS (focal).

It allows remote GUI and web conections.

Based on [tchabaud/amule](https://hub.docker.com/r/tchabaud/amule).

## Configuration

Create local (host) user amule and three directories: conf (usually user's home), incoming and temporary.

## Usage

Start with:

```sh
docker run -p 4711:4711 -p 4712:4712 -p 4662:4662 -p 4672:4672/udp \
    -e PUID=[host_user_id] -e PGID=[host_group_id] \
    -e GUI_PWD=[gui_password] -e WEBUI_PWD=[web_password] \
    -v [host_config_dir]:/home/amule/.aMule \
    -v [host_incoming_dir]:/incoming \
    -v [host_temp_dir]:/temp -d froman68/amuled
```

In next runs, there is no need to include password variables, as they should be in config file.

Finish with:
```sh
sudo killall amuled
```

If you stop using `docker stop froman68/amuled`, daemon is killed ungracefully. For next start file `[host_config_dir]/mulelock` has to be deleted.

### Note about ports:

Docker allows to expose ports and redirect them to others not used in the host system. But amuled doesn't like this because it tries to get a low/high ID sending the port it is listening (I guess). For this reason, if you have to change the ports used in this image it is better to modify the `Dockerfile` and `amule.sh` and rebuild the image. 
