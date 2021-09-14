#!/bin/bash
awk -F ":" '{OFS=":"} {print $1, $7}' /etc/passwd
