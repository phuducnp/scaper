require "nokogiri"
require "httparty"
require "pry"

def scraper
  url = "https://topdev.vn/it-jobs/"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  jobs = Array.new
  job_listings = parsed_page.css('div.job-item-info') # 20 jobs
  job_listings.each do |job_listing|
    job = {
      title: job_listing.css("h2.bold-red").text.strip,
      company: job_listing.css("div.company").text,
      location: job_listing.css("div.location").text.strip,
      url: job_listing.css("a")[0].attributes["href"].value
    }
    jobs << job
  end
end

scraper
