#!/bin/bash

service cron start

exec "$@"
