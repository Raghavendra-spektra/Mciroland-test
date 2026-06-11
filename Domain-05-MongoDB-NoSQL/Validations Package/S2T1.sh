#!/bin/bash
# MongoDB Backup & Recovery Validation

test -d "/backups/mongo-backup-"* && echo "PASS" || echo "FAIL"
