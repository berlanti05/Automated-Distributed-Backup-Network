FROM ubuntu:22.04

RUN apt update && apt install -y \
    rsync \
    openssh-client \
    openssl \
    cron

WORKDIR /app

COPY backup.sh /app/
COPY crontab /etc/cron.d/backup-cron

RUN chmod +x /app/backup.sh
RUN chmod 0644 /etc/cron.d/backup-cron

RUN crontab /etc/cron.d/backup-cron

CMD ["cron", "-f"]
