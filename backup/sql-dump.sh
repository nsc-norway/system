#!/bin/bash

pg_dumpall | gzip > /var/local/backup/data.sql.gz

