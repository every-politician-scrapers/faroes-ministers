#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    POSITION = {
      'varaløgmaður, landsstýrismaður í fíggjarmálum' => ['varaløgmaður', 'landsstýrismaður í fíggjarmálum'],
      'landsstýrismaður í fíggjarmálum, varaløgmaður' => ['varaløgmaður', 'landsstýrismaður í fíggjarmálum'],
    }.freeze

    def name
      noko.text.tidy
    end

    def position
      POSITION.fetch(raw_position, raw_position)
    end

    private

    def raw_position
      noko.xpath('following-sibling::text()').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.c-richtext p strong')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
