# CSDN Crawler

## Initializing

To run the script locally, first change the ```got/``` simlink to your own storage directory, and create an empty ```dump``` file in it. 
The crawled text and code will be placed in the ```dump``` file. 

The program uses a number of libraries, which you can (probably) install with:

```
sudo apt-get install parallel
sudo apt-get install coreutils
sudo apt-get install curl
sudo apt-get install python3-lxml

pip install beautifulsoup4
pip install cchardet
```

This might not be an exhaustive list, so please install additional packages as needed. 

## URL Setup

To reset the url queue, run ```./reset.sh```

To begin crawling from scratch, put starting links in seed_urls/, then run ```./reset.sh```

## Crawling

To execute one round of crawling URLs, run ```./crawl.sh```. 
To crawl for $10$ more rounds, simply run ```for i in {1..10}; do ./crawl.sh; done```


---

Author: Elliot Liu, MediaTek Research Intern
