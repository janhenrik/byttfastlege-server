require 'data_mapper'

class Fastlege
	include DataMapper::Resource

	property :id, Serial
	
	property :navn, String
	property :kjonn, String
	property :praksisnavn, String
	property :tiljengelig, String
	property :adresse, String
	property :poststed, String
	property :gruppepraksis, String
	property :fellesliste, String
	property :paalisten, String
	property :ledig, String

end
