import time

# st = time.time()

from bs4 import BeautifulSoup

# print(time.time() - st)

import lxml
import bs4
import sys
import re
import cchardet as chardet


MIN_LENGTH=2

# exit(0)

def clean(s):
	return re.sub("\s\s+" , " ", s.strip())

def lightclean(s):
	return re.sub("\n\n\n", "\n\n",s.strip())

def output(tp, s):
	print(tp)
	print("-"*16)
	print(s)
	print("="*16)

# guess = Guess()
# def getlang(s):
# 	p = guess.probabilities(s)
# 	if p[0][1] < 0.10:
# 		return "not code"
# 	else:
# 		return p[0][0]

# def blocktype(s):
# 	pass

LICENSES = ['CC 4.0 BY-SA', ]

def get_license(_soup):
	# The default license on these blogs for original work is CC 4.0 BY-SA
	# If the blog is a rehash of another, there is no license. Instead, 
	# there should be a link to the original blog
	try:
		return clean(_soup.find("div",class_="article-copyright").text)
	except:
		return None


fi = sys.argv[1]

# This doesn't support all encodings, but should be good enough for now
cont = open(str(fi), 'r').read()
soup = bs4.BeautifulSoup(cont, 'lxml')


####################
## Get the article's content element (f), title, stars, and license

f = soup.find(id='article_content')
if f == None:
	exit(0)

try:
	output("Title", soup.find("h1",class_="title-article").text)
	
except:
	pass

stars = 0

try:
	stars = clean(soup.find("span",class_="count get-collection").text)
except:
	pass


license = get_license(soup)
output("License", license)
output("Stars", stars)
####################

blocks = []
known_tags = {'p':'Text','h1':'Header','h2':'Header','h3':'Header','h4':'Text','code':'Code','a':'Link'}
output_types = {'Header','Text','Code'} # Edit if you wish to change the set of output items 

def dfs(e): 
# Using DFS to search because some code blocks have 
# very irregular HTML schemes due to syntax highlighting
	if isinstance(e,bs4.element.NavigableString):
		return
	if e.name in known_tags:
		txt = lightclean(e.text)
		if e.name != 'code' and len(re.findall(r'[\s]', txt)) > len(txt) * 0.25:
			txt = clean(txt)
		if len(clean(txt)) < MIN_LENGTH:
			return
		cat = known_tags[e.name]
		if not cat in output_types:
	 		return
		if (len(blocks) > 0 and (cat == blocks[-1][0]) 
			and (cat == 'Text' or cat == 'Code')):
			blocks[-1][1] += ("\n")+txt
		else:
			blocks.append([cat, txt])
		return
	for ch in e.children:
		dfs(ch)
	return
dfs(f)

for e in blocks:
	output(e[0], e[1])

# output("Body", f.text)

# print(time.time()-st)

#for e in f:
#	print(e.string)
