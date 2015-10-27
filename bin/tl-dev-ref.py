from bs4 import BeautifulSoup
import urllib2

import os, sys, commands
ticketn = sys.argv[1]

# Set the request parameters
url = sys.argv[1]

# Do the HTTP get request
content = urllib2.urlopen(url).read()

soup = BeautifulSoup(content, 'html.parser')

print soup.body
