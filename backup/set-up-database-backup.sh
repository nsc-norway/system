# Setup of backups on LIMS servers
# This script handles database backup only, file backup to be coordinated with
# restore@usit.uio.no

# This is not meant to be an automatic install script, more of a 
# record of how it was set up. Run these commands as root.

# We choose /var/local/backup as a backup destination
cd /var/local
mkdir backup
touch backup/data.sql.gz
chown -R postgres:postgres backup/
chmod -R o-rx backup/

# Now we create a cron job to dump the database at 23:00 every night
cat <<EOF > /etc/cron.daily/sql-backup
#!/bin/sh
su -c '/usr/local/bin/sql-dump.sh' postgres
EOF
chmod +x /etc/cron.daily/sql-backup

# Then install the /usr/local/bin/sql-dump.sh script and make it executable

# Then run the script '/etc/cron.daily/sql-backup', which should produce no 
# output. Then run this command and see that it contains 
# "PostgreSQL database cluster dump"
## zcat /var/local/backup/data.sql.gz | head
# Also see that this produces (a lot of) output
## zcat /var/local/backup/data.sql.gz | grep clarity
