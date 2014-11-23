page=$(cat "test.html" | tidy -asxhtml -numeric 2> /dev/null)
page=$(echo 'www.citaten.net	FALSE	/	FALSE	0	citatennet	citatenmandje=%7C28218%7C24548%7C21769%7C23971%7C37868%7C27599%7C36173%7C33027%7C33074%7C32336%7C28798%7C26964%7C26180%7C34242%7C26484%7C21809%7C25889%7C38653%7C37014%7C31374%7C29788%7C33313%7C24857%7C36879%7C22191%7C33356%7C31733%7C23302%7C28813%7C26968%7C' | wget -q -S --load-cookies=/dev/stdin -O - "$1" | tidy -asxhtml -numeric 2> /dev/null)
uls=$(echo "$page" | xmllint --html --xpath '//ul[@id="citatenrijen"]' - 2>/dev/null)
ncts=$(echo "$uls" | xmllint --html --xpath 'count(//ul/li)' - 2>/dev/null)
for i in `seq 1 $ncts` #
#for i in `seq 1 1`
do
	citi=$(echo "$uls" | xmllint --html --xpath "//ul/li[$i]" - 2>/dev/null)
	
	ciid=$(echo "$citi" | xmllint --html --xpath '//div[@class="citaten-options"]/@id' - 2>/dev/null | cut -f2 -d'"' | grep -o -P '\d+')
	
	autc=$(echo "$citi" | xmllint --html --xpath '//div[@class="citatenlijst-auteur"]' - 2>/dev/null)
	auth=$(echo "$autc" | xmllint --html --xpath 'normalize-space(//a)' - 2>/dev/null)
	gebs=$(echo "$autc" | xmllint --html --xpath 'normalize-space(//span[@class="auteur-beschrijving"])' - 2>/dev/null)
	desc=$(echo "$autc" | xmllint --html --xpath 'normalize-space(//span[@class="auteur-gebsterf"])' - 2>/dev/null)
	
	quot=$(echo "$citi" | xmllint --html --xpath 'normalize-space(//li/p)' - 2>/dev/null)
	orig=$(echo "$citi" | xmllint --html --xpath 'normalize-space(//div[@class="citatenlijst-oorspronkelijk"]/p[not(@*)])' - 2>/dev/null | sed 's/^Origineel\W*//')
	srce=$(echo "$citi" | xmllint --html --xpath 'normalize-space(//div[@class="citatenlijst-oorspronkelijk"]/p[@class="bron-citaat"])' - 2>/dev/null | sed 's/^Bron\W*//')
	
#	echo "$citi"
	if [ ! -z "$ciid" ]
	then
		echo "'$ciid','$auth','$gebs','$desc','$quot','$orig','$srce'"
	fi
done
