#!/usr/bin/env python
#coding: utf-8
import requests

import os, sys, commands
ticketn = sys.argv[1]

# Set the request parameters
url = 'https://tribalogic.zendesk.com/api/v2/tickets/' + sys.argv[1] + '.json'
user = 'adam.aaron@tribalogic.net'
token = 'ujm4vS1Gn17IpGS3bYOIFI9TibNZ7Va82a6abulX'

# Do the HTTP get request
# response = requests.get(url, auth=(user, pwd))
response = requests.get(url, auth=(user+"/token", token))

# Check for HTTP codes other than 200
if response.status_code != 200: 
    print('Status:', response.status_code, 'Problem with the request. Exiting.')
    exit()

# Decode the JSON response into a dictionary and use the data
data = response.json()

print(data['ticket']['subject'])
