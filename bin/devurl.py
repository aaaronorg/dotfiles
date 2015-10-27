#!/usr/bin/env python
#coding: utf-8

import os, sys, commands
myurl = sys.argv[1]
urltype = sys.argv[2]


def find_nth_overlapping(haystack, needle, n):
    start = haystack.find(needle)
    while start >= 0 and n > 1:
            start = haystack.find(needle, start+1)
            n -= 1
    return start

def toggle_dot_dev(url):
    if url[-4:] == '.dev':
        url = url[:-4]
    else:
        url = url + '.dev'
    return url


# get from 'http' to the domain end (to 3rd '/')
domainend = find_nth_overlapping(myurl, "/", 3)

# split the url into the domain and store everything after in a separate var
url_first, url_second = myurl[:domainend], myurl[domainend:]

if urltype == "dev":
    print(toggle_dot_dev(url_first) + url_second)
elif urltype == "jadmin":
    print(url_first + '/administrator')
elif urltype == "domain":
    print(url_first)
