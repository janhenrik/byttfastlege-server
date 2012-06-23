require 'sinatra'  
require 'haml'  
require 'json'
require_relative 'html_parser.rb'
require_relative 'fastlege.rb'

if ENV['RACK_ENV'] == 'production' then
	DATABASE_URL = ENV['DATABASE_URL']
else
	APP_ROOT = File.expand_path(File.dirname(__FILE__))
	DATABASE_URL = "sqlite3://#{APP_ROOT}/db/db.sqlite3"
end

DataMapper::setup(:default, "#{DATABASE_URL}")
DataMapper.auto_upgrade!

Thread.new {
	HTMLParser.parse
}

get '/' do  
	haml :index  
end  

get '/fastleger' do
	Fastlege.all.to_json
end

# Freetextsearch, navn, praksisnavn, poststed
get '/fastleger/search/:value' do
	like = "%" + params[:value] + "%"
	lege = Fastlege.all(:navn.like => like) |
	Fastlege.all(:praksisnavn.like => like) |
	Fastlege.all(:poststed.like => like)
	lege.to_json
end


get '/fastleger/:attribute/:value' do
	like = "%" + params[:value] + "%"
	Fastlege.all(params[:attribute].to_sym.like => like).to_json
end

get '/fastleger/:attribute/:value/count' do
	like = "%" + params[:value] + "%"
	Fastlege.count(params[:attribute].to_sym.like => like).to_json
end

get '/fastlege/:id' do
	Fastlege.get(params[:id]).to_json
end

