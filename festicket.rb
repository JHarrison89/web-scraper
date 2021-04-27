require 'HTTParty'
require 'Nokogiri'
require 'watir'
require 'webdrivers/chromedriver'
require 'byebug'

browser = Watir::Browser.new
browser.goto 'https://apply.workable.com/festicket/?lng=en'

while browser.button(text: 'Show more').present?
  browser.button(text: 'Show more').click
  sleep 1
end

parse_page = Nokogiri::HTML(browser.html)
job_listings = parse_page.css('.careers-jobs-list-styles__job--3Cb9F') # 36
jobs = []

job_listings.each do |job_listing|
  job = {
    title: job_listing.css('.careers-jobs-list-styles__title--1cN5S').text.strip,
    employer: 'Festicekt',
    location: job_listings.css(:id, 'job-location').text.strip,
    short_desc: '',
    link: job_listing.css('.careers-jobs-list-styles__title--1cN5S').css('a')[0].attributes['href'].value,
    # long_desc: Nokogiri::HTML(HTTParty.get(job_listings[0].css('.careers-jobs-list-styles__title--1cN5S').css('a')[0].attributes['href'].value)).css('.container').css('.details-body__content').text
  }

  puts job
  jobs << job
end

byebug
sleep 10
