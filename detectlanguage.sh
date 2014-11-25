#!/bin/bash
cd "jsli/lib"; node -e "require('./loader.js').identify('$1').language;" -p
