tmp=$(cat)
while read rul
do
	>&2 echo "$rul"
	tmp=$(echo "$tmp" | sed "s/$rul/g")
done < replacements
echo "$tmp"
