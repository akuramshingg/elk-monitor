#!/bin/sh

# Usage: <path_to_export_json>

DIR=`dirname $0`

NODE_PATH=$DIR/node_modules node $DIR/sort_export.js $1