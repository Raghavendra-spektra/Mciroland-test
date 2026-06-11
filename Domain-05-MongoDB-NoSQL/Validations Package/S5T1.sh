#!/bin/bash
# Redis Caching Validation

redis-cli ping | grep -q "PONG" && echo "PASS" || echo "FAIL"
