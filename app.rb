require 'rubygems'  
require 'sinatra'  
require 'haml'  
require 'json'
require_relative 'html_parser.rb'
require_relative 'fastlege.rb'

DataMapper.setup(:default, "sqlite3::memory:")	
DataMapper.auto_migrate!
puts "INIT"

Thread.new {
	puts "Parsing...."
	HTMLParser.parse
	puts "Parseing done..."
}

get '/' do  
	haml :index  
end  

get '/fastleger.json' do
	content_type :json
	HTMLParser.parse.to_json
end

get '/fastlege/:id' do
  lege = Fastlege.get(params[:id])
  lege.to_json
end
