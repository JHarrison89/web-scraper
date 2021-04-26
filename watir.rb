require 'HTTParty'
require 'Nokogiri'
require 'watir'
require 'webdrivers/chromedriver'
require 'byebug'

browser = Watir::Browser.new
browser.goto 'https://www.doorsopen.co/jobs/?q=&l=UK'
browser.button(text: 'Load more').click
sleep 1
parse_page = Nokogiri::HTML(browser.html)
job_listings = parse_page.css('.listing-item') # 36
jobs = []

job_listings.each do |job_listing|
  job = {
    title: job_listing.css('.media-heading').text.strip,
    employer: job_listing.css('.listing-item__info--item-company').text.strip,
    location: job_listing.css('.listing-item__info--item-location').text.strip,
    short_desc: job_listing.css('.listing-item__desc').text,
    link: job_listing.css('.media-body').css('a')[0].attributes['href'].value,
    long_desc: Nokogiri::HTML(HTTParty.get(job_listings[0].css('.media-body').css('a')[0].attributes['href'].value)).css('.container').css('.details-body__content').text
  }

  puts job
  jobs << job
end

# byebug
# sleep 10
