FROM jrei/systemd-debian:12

# Install prequisites
RUN apt update && \
  apt install -y debian-keyring debian-archive-keyring apt-transport-https curl

# Create directory to hold Caddyfile
RUN mkdir -p /etc/caddy

# Install Caddy
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && \
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
  apt update && \
  apt install -y caddy

# Copy Caddyfile to container
COPY Caddyfile /etc/caddy/Caddyfile

# Get trusted key for Netdata
RUN curl -fsSL https://packagecloud.io/netdata/netdata/gpgkey | gpg --dearmor > /etc/apt/keyrings/netdata_netdata-archive-keyring.gpg

# Copy Netdata  list
COPY netdata.list /etc/apt/sources.list.d/netdata.list

# Install Netdata
RUN apt update && \
  apt install -y netdata

# Copy Netdata config
COPY netdata.conf /etc/netdata/netdata.conf
