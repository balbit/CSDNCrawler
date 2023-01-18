# CSDN Crawler

## Initializing

To run the script locally, first change the got/ simlink to your own storage directory, and create an empty ```dump``` file in it. 
The crawled text and code will be placed in the ```dump``` file. 

To reset the url queue, run ```./reset.sh```

## URL Setup

To begin crawling from scratch, put starting links in seed_urls/, then run ```./reset.sh```

## Crawling

To execute one round of crawling URLs, run ```./crawl.sh```. 
To crawl more, simply run ```for i in {1..10}; do ./crawl.sh; done```

