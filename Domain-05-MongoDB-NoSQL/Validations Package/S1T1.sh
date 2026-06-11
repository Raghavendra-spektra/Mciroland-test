#!/bin/bash
# MongoDB Replica Set Validation

mongo --eval "rs.status()" | grep -q "ok" && echo "PASS" || echo "FAIL"
