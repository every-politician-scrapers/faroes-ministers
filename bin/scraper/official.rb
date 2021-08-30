#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.text.tidy
    end

    def position
      noko.xpath('following-sibling::text()').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.c-richtext p strong')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
