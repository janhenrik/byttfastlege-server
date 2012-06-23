require 'rubygems'
require 'nokogiri'  
require 'data_mapper'
require 'dm-migrations'
require_relative 'fastlege.rb'

class HTMLParser

	@@attr_map = {
		0 => :navn=,
		1 => :kjonn=,
		2 => :praksisnavn=,
		3 => :tiljengelig=,
		4 => :adresse=,
		5 => :poststed=,
		6 => :gruppepraksis=,
		7 => :fellesliste=,
		8 => :paalisten=,
		9 => :ledig=
	}

	def self.parse
		fastleger = Fastlege.all
		if fastleger.empty? then
			puts "Database empty, rebuilding database..."
			page = Nokogiri::HTML(open("testfiles/fastleger.html"))

			fastleger = page.css('table#fastlege').css('tbody').css('tr').css('td')
						.each_with_index.reduce([]) do |leger, node| 
				index = node.last % 10
				nodetekst = node.first.text.gsub("\n",'').gsub("\r",'').gsub("\t",'')
				leger << Fastlege.new if index == 0
				leger.last.send(@@attr_map[index], nodetekst)
				leger.last.save
				leger
			end
		else
			puts "Database allready there. OK!"
		end
		fastleger
	end

end

