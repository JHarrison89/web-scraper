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
    link: 'https://apply.workable.com' + job_listing.css('a')[0]['href']
    # long_desc: Nokogiri::HTML(HTTParty.get('https://apply.workable.com' + job_listings[0].css('a')[0]['href'])).css('.job-preview-styles__preview--2d3Fz').text
  }

  browser.goto 'https://apply.workable.com' + job_listing.css('a')[0]['href']
  sleep 2
  parse_page = Nokogiri::HTML(browser.html)
  desc = parse_page.css('.job-preview-styles__description--2BkR3').text

  p job[:long_desc] = desc

  puts job
  jobs << job
end

# a = HTTParty.get('https://apply.workable.com' + job_listings[0].css('a')[0]['href'])
# b = Nokogiri::HTML(HTTParty.get('https://apply.workable.com' + job_listings[0].css('a')[0]['href']))

# one = Nokogiri::HTML(HTTParty.get('https://apply.workable.com' + job_listings[0].css('a')[0]['href']))
# two = Nokogiri::HTML(HTTParty.get('https://apply.workable.com' + job_listings[0].css('a')[0]['href'])).css('.job-preview-styles__preview--2d3Fz').text
# browser.goto 'https://apply.workable.com' + job_listings[0].css('a')[0]['href']
# parse_page = Nokogiri::HTML(browser.html)
# desc = parse_page.css('.job-preview-styles__preview--2d3Fz').text

# long_desc = Nokogiri::HTML(HTTParty.get('https://apply.workable.com' + job_listings[0].css('a')[0]['href'])).css('.job-preview-styles__preview--2d3Fz').text


byebug
sleep 10


# a = Nokogiri::HTML(Watir::Browser.new.goto('https://apply.workable.com' + job_listings[0].css('a')[0]['href']).html).css('.job-preview-styles__preview--2d3Fz').text

# # long_desc: Nokogiri::HTML(HTTParty.get(job_listings[0].css('.media-body').css('a')[0].attributes['href'].value)).css('.container').css('.details-body__content').text
# Nokogiri::HTML(HTTParty.get(job_listings[0].css('.media-body').css('a')[0].attributes['href'].value)).css('.container').css('.details-body__content').text
# Nokogiri::HTML(HTTParty.get("https://apply.workable.com/festicket/j/16F4FCA96B/")).css('.job-preview-styles__preview--2d3Fz')
