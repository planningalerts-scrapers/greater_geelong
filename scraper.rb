require 'scraperwiki'
require 'nokogiri'
require 'date'

base_url = 'http://www.geelongaustralia.com.au/advertisedplanning/'
applications_url = 'http://www.geelongaustralia.com.au/advertisedplanning/default.aspx'
html = ScraperWiki.scrape applications_url
page = Nokogiri.parse html
table = page.at 'table#ctl00_ContentBody_GV_FINISHED'

table.search('tr').each do |r|
  next if r.at('th')

  application_url = base_url + r.at('a').attr('href')

  # TODO: We don't need to scrape the detail page if we've already saved this DA
  detail_page = Nokogiri.parse(ScraperWiki.scrape(application_url))
  description = detail_page.at("#ctl00_ContentBody_FV_MAIN_P_COMMENT").next_element.inner_text.strip

  address = "#{r.search('td')[0].inner_text.strip}, #{r.search('td')[1].inner_text.strip}, VIC"

  record = {
    :council_reference => r.search('td')[2].inner_text.strip,
    :address => address,
    :on_notice_to => Date.parse(r.search('td')[3].inner_text).to_s,
    :info_url => application_url,
    :description => description,
    :date_scraped => Date.today.to_s
  }
  ScraperWiki.save_sqlite([:council_reference], record)
end
