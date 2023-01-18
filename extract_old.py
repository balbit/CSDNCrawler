import lxml
from lxml import etree
from io import StringIO, BytesIO
import sys
import re
import cchardet as chardet

MIN_LENGTH=2


def clean(s):
	return re.sub("\s\s+" , " ", s.strip())

def output(tp, s):
	print(tp)
	print("-"*16)
	print(s)
	print("="*16)

def blocktype(s):
	pass

def text(xml_tag):
	return xml_tag.text_content()

LICENSES = ['CC 4.0 BY-SA', ]

def get_license(root):
	# The default license on these blogs for original work is CC 4.0 BY-SA
	# If the blog is a rehash of another, there is no license. Instead, 
	# there should be a link to the original blog
	try:
		return clean(text(root.xpath("//div[@class = 'article-copyright']")[0]))
	except:
		return None



fi = sys.argv[1]

# print("wut")

# FIX!!!!!!! This doesn't support all encodings
root = etree.parse(fi)


f = root.xpath("//div[@id = 'article_content']")[0]

if f == None:
	exit(0)

try:
	output("Title", text(root.xpath("//h1[@class = 'title-article']")[0]))
except:
	pass

stars = 0

try:
	stars = clean(text(root.xpath("//span[@class = 'count get-collection']")[0]))
except:
	pass

license = get_license(root)
output("License", license)


output("Stars", stars)
# for e in f.descendants:
# 	if isinstance(e,bs4.element.NavigableString):
# 		pass

# to = open("out", "a")

output("Content", text(f))


#for e in f:
#	print(e.string)
