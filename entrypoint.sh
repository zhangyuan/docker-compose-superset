#!/usr/bin/env bash

set -e

nginx

su superset

superset $@
