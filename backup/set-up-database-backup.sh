# Setup of backups on LIMS servers
# This script handles database backup only, file backup to be coordinated with
# restore@usit.uio.no

# This is not meant to be an automatic install script, more of a 
# record of how it was set up. Run these commands as root.

# We choose /var/local/backup as a backup destination
cd /var/local
mkdir backup
chown postgres:postgres backup/
touch backup/data.sql.gz
chmod -R o-rx backup/

# Now we create a cron job to dump the database at 23:00 every night
cat <<EOF > /etc/cron.daily/sql-backup
#!/bin/sh
su -c '/usr/local/bin/sql-dump.sh' postgres
EOF
chmod +x /etc/cron.daily/sql-backup

# Then install the sql-dump.sh script and make it executable

