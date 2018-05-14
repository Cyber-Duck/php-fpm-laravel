#!/bin/bash

# Start cron service
service cron start

exec "$@"
