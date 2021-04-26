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
# title = parse_page.css('.media-heading')
# employer = parse_page.css('.listing-item__info--item-company')
# location = parse_page.css('.listing-item__info--item-location')
# short_desc = parse_page.css('.listing-item__desc')
# link = parse_page.css('.media-body').css('a')[0].attributes["href"].value

# job_listings.each_with_index do |job_listing, index|
#  puts "# #{index}: #{title[index].text} - #{employer[index].text} - #{location[index].text} - #{short_desc[index].text} - #{link[index]}"
# end

jobs = []
job_listings.each do |job_listing|
  job = {
    title: job_listing.css('.media-heading').text.strip,
    employer: job_listing.css('.listing-item__info--item-company').text.strip,
    location: job_listing.css('.listing-item__info--item-location').text.strip,
    short_desc: job_listing.css('.listing-item__desc').text,
    link: job_listing.css('.media-body').css('a')[0].attributes['href'].value,
    long_desc: Nokogiri::HTML(HTTParty.get(job_listing.css('.media-body').css('a')[0].attributes['href'].value)).css('.container').text

  }
  puts job
  jobs << job
end

byebug
sleep 10

    # doc = HTTParty.get(link),
    # parse_page = Nokogiri::HTML(doc),
    # long_desc: parse_page.css('.product-card__title')
