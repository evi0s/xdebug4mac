# xdebug4mac

Xdebug For Docker-for-Mac

## Usage

### Build

```bash
docker build -t evi0s/xdebug4mac .
```

### Run

```bash
docker run -it -d \
    --name=xdebug4mac \
    -p 60080:80 \
    -p 63306:3306 \
    -p 60022:22 \
    -v /Users/evi0s/PhpstormProjects/html/:/var/www/html \
    evi0s/xdebug4mac
```

## Options

Following are environs:

* entrypoint debug mode: specified by DEBUG
* Xdebug remote port: specified by XDEBUGPORT, default: 9010
* Database name: specified by DBNAME, default: user
* Database username: specified by DBUSER, default user
* Database password: specified by DBPASS, default random password

Example:

```bash
docker run -it -d \
    --name=xdebug4mac \
    -p 60080:80 \
    -p 63306:80 \
    -p 60022:22 \
    -v /path/to/your/project:/var/www/html \
    -e DEBUG=true \
    -e XDEBUGPORT=9001 \
    -e DBNAME=user \
    -e DBUSER=user \
    -e DBPASS=y0ur_0wn_p45sw0rd \
    xdebug4mac
```

If DBPASS not set, you can simply run `docker logs ${your_container_name}` to see the default password of the database.

There is also a default ssh user: `user:user` for PHPStorm remote server, which means you can use ssh to have a shell:

```
$ ssh user@localhost -p 60022
Password: user
```

## Configuration

