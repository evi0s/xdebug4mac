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
    -p 8086:80 -v /Users/evi0s/PhpstormProjects/html/:/var/www/html \
    evi0s/xdebug4mac
```

