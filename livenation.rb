require 'HTTParty'
require 'Nokogiri'
require 'watir'
require 'webdrivers/chromedriver'
require 'byebug'

browser = Watir::Browser.new
browser.goto 'https://livenation.wd1.myworkdayjobs.com/LNExternalSite/0/refreshFacet/318c8bb6f553100021d223d9780d30be'
# sleep 4

parse_page = Nokogiri::HTML(browser.html)
location = parse_page.css('#compositeContainer') # 36
byebug
# browser.css('WFLF').checkbox(id: 'wd-FacetValue-CheckBox-Location_Country::bc33aa3152ec42d4995f4791a106ed09-input').set(true)
# checkbox.check
sleep 4

# while browser.button(text: 'Load more').present?
#   browser.button(text: 'Load more').click
#   sleep 1
# end

# parse_page = Nokogiri::HTML(browser.html)
# job_listings = parse_page.css('.listing-item') # 36
# jobs = []

# job_listings.each do |job_listing|
#   job = {
#     title: job_listing.css('.media-heading').text.strip,
#     employer: job_listing.css('.listing-item__info--item-company').text.strip,
#     location: job_listing.css('.listing-item__info--item-location').text.strip,
#     short_desc: job_listing.css('.listing-item__desc').text,
#     link: job_listing.css('.media-body').css('a')[0].attributes['href'].value,
#     long_desc: Nokogiri::HTML(HTTParty.get(job_listings[0].css('.media-body').css('a')[0].attributes['href'].value)).css('.container').css('.details-body__content').text
#   }

#   puts job
#   jobs << job
# end

# byebug
# sleep 10
