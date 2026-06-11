#!/bin/bash
# Cassandra Schema Validation

cassandra-cli describe keyspace events | grep -q "activity" && echo "PASS" || echo "FAIL"
