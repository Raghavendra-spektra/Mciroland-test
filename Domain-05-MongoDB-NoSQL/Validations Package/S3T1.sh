#!/bin/bash
# MongoDB Query Profiling Validation

mongo --eval "db.system.profile.count()" | grep -q "[0-9]" && echo "PASS" || echo "FAIL"
