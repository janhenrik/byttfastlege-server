require 'rubygems'
require 'nokogiri'  

class Fastlege
	attr :navn, true
	attr :kjonn, true
	attr :praksisnavn, true
	attr :tiljengelig, true
	attr :adresse, true
	attr :poststed, true
	attr :gruppepraksis, true
	attr :fellesliste, true
	attr :paalisten, true
	attr :ledig, true

	def to_s
		"#{navn}/#{kjonn}/#{praksisnavn}/#{adresse}/#{poststed}/#{gruppepraksis}/#{fellesliste}/#{paalisten}/#{ledig}"
	end
end

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


def parse
	page = Nokogiri::HTML(open("testfiles/fastleger.html"))   
	
	fastleger = page.css('table#fastlege').css('tbody').css('tr').css('td').each_with_index.reduce([]) do |leger, node| 
		index = node.last % 10
		nodetekst = node.first.text
		leger << Fastlege.new if index == 0
		leger.last.send(@@attr_map[index], nodetekst)
		leger
	end
	fastleger
end

puts parse