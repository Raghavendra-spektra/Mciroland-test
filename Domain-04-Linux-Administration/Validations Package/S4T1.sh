#!/bin/bash
# SELinux Configuration Validation

getenforce | grep -q "Enforcing" && echo "PASS" || echo "FAIL"
