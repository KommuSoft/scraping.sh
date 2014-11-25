#!/bin/bash
#Language detection is sometimes useful to make decisions in scraping or to classify content
cd "jsli/lib"; node -e "require('./loader.js').identify('$1').language;" -p
