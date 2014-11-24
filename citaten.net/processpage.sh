#!/bin/bash
basket=$(seq "$1" "$2" | sed ':a;N;$!ba;s/\n/%7C/g')
page=$(echo "www.citaten.net	FALSE	/	FALSE	0	citatennet	citatenmandje=%7C$basket%7C" | wget -q -S --load-cookies=/dev/stdin -O - "http://www.citaten.net/zoeken/citaten_in_mandje.html" 2>/dev/null | tidy -asxhtml -numeric 2> /dev/null)
uls=$(echo "$page" | xmllint --html --xpath '//ul[@id="citatenrijen"]' - 2>/dev/null)
ncts=$(echo "$uls" | xmllint --html --xpath 'count(//ul/li)' - 2>/dev/null)
for i in `seq 1 $ncts` #
#for i in `seq 1 1`
do
	citi=$(echo "$uls" | xmllint --html --xpath "//ul/li[$i]" - 2>/dev/null)
	
	ciid=$(echo "$citi" | xmllint --html --xpath '//div[@class="citaten-options"]/@id' - 2>/dev/null | cut -f2 -d'"' | grep -o -P '\d+')
	
	autc=$(echo "$citi" | xmllint --html --xpath '//div[@class="citatenlijst-auteur"]' - 2>/dev/null)
	auti=$(echo "$autc" | xmllint --html --xpath '//a/@href' - 2>/dev/null | cut -f2 -d'"' | sed 's#^http://www.citaten.net/zoeken/citaten_van-##' | sed 's#.html$##')
	auth=$(echo "$autc" | xmllint --html --xpath 'normalize-space(//a)' - 2>/dev/null)
	gebs=$(echo "$autc" | xmllint --html --xpath 'normalize-space(//span[@class="auteur-beschrijving"])' - 2>/dev/null)
	desc=$(echo "$autc" | xmllint --html --xpath 'normalize-space(//span[@class="auteur-gebsterf"])' - 2>/dev/null)
	
	quot=$(echo "$citi" | xmllint --html --xpath 'normalize-space(//li/p)' - 2>/dev/null)
	orig=$(echo "$citi" | xmllint --html --xpath 'normalize-space(//div[@class="citatenlijst-oorspronkelijk"]/p[not(@*)])' - 2>/dev/null | sed 's/^Origineel\W*//')
	srce=$(echo "$citi" | xmllint --html --xpath 'normalize-space(//div[@class="citatenlijst-oorspronkelijk"]/p[@class="bron-citaat"])' - 2>/dev/null | sed 's/^Bron\W*//')
	vots=$(echo "$citi" | xmllint --html --xpath 'normalize-space(//div[@class="votes-content"])' - 2>/dev/null)
	
	if [ ! -z "$ciid" ]
	then
		echo "'$ciid','$auti','$auth','$gebs','$desc','$quot','$orig','$srce','$vots'"
	fi
done
