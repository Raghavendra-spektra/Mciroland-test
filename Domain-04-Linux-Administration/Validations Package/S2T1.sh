#!/bin/bash
# Pacemaker Cluster Validation

pcs status | grep -q "Online" && echo "PASS" || echo "FAIL"
