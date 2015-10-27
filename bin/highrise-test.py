#!/usr/bin/env python
#coding: utf-8
#import Highton
from highton import Highton

#initialize it
high = Highton(api_key = '86348df5571aa8e25b9e2d1d3b32249f', user = 'sitefinder')

print "============== D E A L S ==============="
deals = high.get_deals_since('20140601000000')

for deal in deals:
    print "D E A L------------------"
    print "account_id: {}".format(deal.account_id)
    print "author_id: {}".format(deal.author_id)
    print("background: " + deal.background)
    print "category_id: {}".format(deal.category_id)
    print "created_at: {}".format(deal.created_at)
    print "currency: {}".format(deal.currency)
    print "duration: {}".format(deal.duration)
    print "group_id: {}".format(deal.group_id)
    print "highrise_id: {}".format(deal.highrise_id)
    print "name: {}".format(deal.name)
    print "owner_id: {}".format(deal.owner_id)
    print "party_id: {}".format(deal.party_id)
    print "price: {}".format(deal.price)
    print "price_type: {}".format(deal.price_type)
    print "responsible_party_id: {}".format(deal.responsible_party_id)
    print "status: {}".format(deal.status)
    print "status_changed_on: {}".format(deal.status_changed_on)
    print "updated_at: {}".format(deal.updated_at)
    print "visible_to: {}".format(deal.visible_to)
    print "category: {}".format(deal.category.name)
    print "party: {}".format(deal.party.name)
    i = 0
    for party in deal.parties:
        print "parties {first_name} {last_name}".format(first_name = deal.parties[i].first_name,last_name = deal.parties[i].last_name)
        i = i + 1

print "============== P E O P L E ==============="
people = high.get_people()

for person in people:
    print "P E R S O N ----------"
    print "highrise_id: {}".format(person.highrise_id)
    print "first_name: {}".format(person.first_name)
    print "last_name: {}".format(person.last_name)
    print "title: {}".format(person.title)
    print "background: {}".format(person.background)
    print "linkedin_url: {}".format(person.linkedin_url)
    print "avatar_url: {}".format(person.avatar_url)
    print "company_id: {}".format(person.company_id)
    print "company_name: {}".format(person.company_name)
    print "created_at: {}".format(person.created_at)
    print "updated_at: {}".format(person.updated_at)
    print "visible_to: {}".format(person.visible_to)
    print "owner_id: {}".format(person.owner_id)
    print "group_id: {}".format(person.group_id)
    print "author_id: {}".format(person.author_id)
    i = 0
    for phone_number in person.phone_numbers:
        print "number {number} location {location}".format(number = person.phone_numbers[i].number, location = person.phone_numbers[i].location)
        i = i + 1
    i = 0
    for email in person.email_addresses:
        print "address {address} location {location}".format(address = person.email_addresses[i].address, location = person.email_addresses[i].location)
        i = i + 1
    for subject_data in person.subject_datas:
        print "{label} : {value}".format(label = person.subject_datas[i].subject_field_label, value = person.subject_datas[i].value)
        i = i + 1
    i = 0
    for tag in person.tags:
        print "{name}".format(name = person.tags[i].name)
        i = i + 1

print "============== C O M P A N I E S ==============="
companies = high.get_companies()

for company in companies:
    print "C O M P A N Y ----------"
    print "highrise_id: {}".format(company.highrise_id)
    print "background: {}".format(company.background)
    print "company_name: {}".format(company.name)
    print "created_at: {}".format(company.created_at)
    print "updated_at: {}".format(company.updated_at)
    print "visible_to: {}".format(company.visible_to)
    print "owner_id: {}".format(company.owner_id)
    print "group_id: {}".format(company.group_id)
    print "author_id: {}".format(company.author_id)
    i = 0
    for phone_number in company.phone_numbers:
        print "number {number} location {location}".format(number = company.phone_numbers[i].number, location = company.phone_numbers[i].location)
        i = i + 1
    i = 0
    for email in company.email_addresses:
        print "address {address} location {location}".format(address = company.email_addresses[i].address, location = company.email_addresses[i].location)
        i = i + 1
    i = 0
    for subject_data in company.subject_datas:
        print "{label} : {value}".format(label = company.subject_datas[i].subject_field_label, value = company.subject_datas[i].value)
        i = i + 1
    i = 0
    print "tags: ["
    for tag in company.tags:
        print "{name}".format(name = company.tags[i].name)
        i = i + 1
    print "]"
