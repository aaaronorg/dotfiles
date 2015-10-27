#!/usr/bin/env python
#coding: utf-8
#import Highton
from highton import Highton

#initialize it
high = Highton(api_key = '86348df5571aa8e25b9e2d1d3b32249f', user = 'sitefinder')

person_tasks = high.get_person_tasks('person_highrise_id')
company_tasks = high.get_company_tasks('company_highrise_id')
deal_tasks = high.get_deal_tasks('deal_highrise_id')

print "============== T A S K S ==============="
