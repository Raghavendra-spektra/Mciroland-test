#!/bin/bash
# Network Connectivity Validation

ping -c 1 8.8.8.8 > /dev/null 2>&1 && echo "PASS" || echo "FAIL"
