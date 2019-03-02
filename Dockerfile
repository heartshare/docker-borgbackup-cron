FROM ovski/ansible:v2.7.8

# Install borg
RUN apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    python-virtualenv \
    libssl-dev openssl \
    libacl1-dev libacl1 \
    build-essential \
    borgbackup

# Install cron
RUN apt-get install -y cron

COPY entrypoint.sh /var/entrypoint.sh
RUN chmod +x /var/entrypoint.sh

COPY backup_script.sh /var/backup_script.sh
RUN chmod +x /var/backup_script.sh

COPY borgbackup_cron /etc/cron.d/borgbackup_cron
RUN chmod +x /etc/cron.d/borgbackup_cron
RUN crontab /etc/cron.d/borgbackup_cron

CMD [ "/var/entrypoint.sh" ]