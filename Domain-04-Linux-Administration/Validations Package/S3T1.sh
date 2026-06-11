#!/bin/bash
# Disk Space Management Validation

df -h | grep -q "/var/log" && echo "PASS" || echo "FAIL"
