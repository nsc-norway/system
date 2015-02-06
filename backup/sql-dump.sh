#!/bin/bash

# SQL dump script for LIMS servers

pg_dumpall | gzip > /var/local/backup/data.sql.gz

