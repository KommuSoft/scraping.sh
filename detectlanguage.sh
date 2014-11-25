#!/bin/bash
#Language detection is sometimes useful to make decisions in scraping or to classify content
cat | while read o
do
	lng=$(cd "jsli/lib"; node -e "require(\"./loader.js\").identify('$o').language;" -p)
	echo "('$o','$lng')"
done
