require 'HTTParty'
require 'Nokogiri'

puts 'Hello, Im a scraper!'

doc = HTTParty.get('https://www.nike.com/gb/w/mens-nike-by-you-lifestyle-shoes-13jrmz6ealhznik1zy7ok')
parse_page = Nokogiri::HTML(doc)

names = parse_page.css('.product-card__title')
prices = parse_page.css('.product-card__price')

(0...names.size).each do |index|
  puts "# #{index}: #{names[index].text} --- #{prices[index].text}"
end

# names.each do |name|
#   puts name.text
# end

# class Scraper
#   attr_accessor :parse_page

#   def initialize
#   end
# end

# scraper = Scraper.new
