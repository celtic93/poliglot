require 'nokogiri'
require 'open-uri'
require 'pry'
# require 'json'
# require 'fileutils'

class ParserService
  # URL = "https://kreekly.com/lists/10000-samyh-populyarnyh-angliyskih-slov/".freeze

  # def self.call
  #   page = Nokogiri::HTML(URI.open(URL))

  #   words = page.css('.dict-word')

  #   words.each do |word|
  #     Word.create(en: word.children[2].text, ru: word.children[3].text)
  #   end
  #   words.first
  # end

  # URL = ["https://en.m.wiktionary.org/wiki/Wiktionary:Frequency_lists/PG/2006/04/1-10000".freeze,
  #         "https://en.m.wiktionary.org/wiki/Wiktionary:Frequency_lists/PG/2006/04/10001-20000".freeze,
  #         "https://en.m.wiktionary.org/wiki/Wiktionary:Frequency_lists/PG/2006/04/20001-30000".freeze,
  #         "https://en.m.wiktionary.org/wiki/Wiktionary:Frequency_lists/PG/2006/04/30001-40000".freeze]

  # def self.call
  #   URL.each do |url|
  #     page = Nokogiri::HTML(URI.open(url))

  #     words = page.css('tr')

  #     words.each do |word|
  #       if word.children[0].text.to_i > 0
  #         upd = Word.find_by_en(word.children[2].text)
  #         upd.update(position: word.children[0].text.to_i) if upd
  #       end
  #     end
  #     words.first
  #   end
  # end

  # def self.call
  #   a = 40000
  #   words = Word.where(position: nil)
  #   words.each do |word|
  #     word.update(position: a)
  #     a += 1
  #   end
  #   a
  # end

  # def self.call
  #   a = 1
  #   while Word.where(level: nil).any? do
  #     Word.where(level: nil).first(100).map { |w| w.update(level: a) }
  #     a += 1
  #   end
  # end
end
