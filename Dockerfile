FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get upgrade --yes \
 && echo tzdata tzdata/Areas select Europe | debconf-set-selections \
 && echo tzdata tzdata/Zones/Europe select Berlin | debconf-set-selections \
 && apt-get install --yes --no-install-recommends \
                    apt-utils tzdata \
                    supervisor cron \
                    unattended-upgrades \
 && mkdir -p /etc/supervisor/conf.d

COPY supervisor.conf /etc/
COPY supervisor-cron.conf /etc/supervisor/conf.d/cron.conf
COPY apt-50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades
COPY apt-20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
