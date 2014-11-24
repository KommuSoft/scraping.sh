# Scraping.sh

**Scrape** /skrāp/ \[verb\] push or pull a hard or sharp implement across (a surface or object) so as to remove dirt or other matter.

A repository that contains various scripts to scrape data from public websites that fail to provide a (well-documented) API or dump.

## Statement

*Many websites provide useful data. The only problem is that the data is not accessible by machines. This is problematic since most applications require to interact with multiple databases. This repository does not intend theft of copyrighted material: the data was already available. It shows however ways to produce them in a machine-readable format.*

This repository aims to do something about it by providing a tool set of scrapers (as well as documentation), to scrape data from websites.

## Building a scraper

Websites produce `.html` pages. A scraper aims to analyze the page, remove the dirty parts and analyze and process the remaining parts.

Many scrapers follow the same pipeline:

 - Use `wget` or `curl` to obtain the webpage, sometimes one needs to *inject* cookies first:
```
    echo "cookie" | wget -q -S --load-cookies=/dev/stdin -O - "webpage"
```
 
 - Run the resulting `.html` file through `tidy` to convert the file to an `.xhtml` file:
```
    tidy -asxhtml -numeric
```
 
 - If the file is a valid `.xhtml` file, one can process it using *XPath*: a query system to analyze `.xml` files.
```
    xmllint --html --xpath "//tag1//tag2[@attribute=value]" -
```