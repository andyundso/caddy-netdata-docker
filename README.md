# Netdata behind Caddy

This repo is a minimal version to reproduce the 401 bug with Netdata behind Caddy.

Build the image:

```
docker build -t netdata-caddy .
```

Run the image:

```
docker run -d --rm --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:rw -p 8080:8080 netdata-caddy
```

Access the dashboard at `localhost:8080`. Username is `admin`, and password is `admin` as well.
