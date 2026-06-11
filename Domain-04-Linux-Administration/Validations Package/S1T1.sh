#!/bin/bash
# LVM Extension Validation

lvdisplay | grep -q "data" && echo "PASS" || echo "FAIL"
