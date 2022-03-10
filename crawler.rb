

require 'nokogiri'
require 'open-uri'
require 'csv'

def download_sys
  CSV.open("sys.csv", "w") do |csv|
    doc = Nokogiri::HTML(URI.open('https://says.com/my'))
    doc.css('.latest-column ul').each do |link|
      link.css('.story-image').each do |image|
        csv << [image['data-lazy'],image.css('.ga-featured-story').first.content]
      end
    end
  end
end

def download_therakayatpost
  CSV.open("therakayatpost.csv", "w") do |csv|
    doc = Nokogiri::HTML(URI.open('https://www.therakyatpost.com'))
    doc.css('.thb-post-grid-style5 .post').each do |link|
      csv << [link.css('.post-gallery').first.css('a img')[0]['src'], link.css('.style10-content-column .post-title span').first.content]
    end
  end
end

download_sys()
download_therakayatpost()
