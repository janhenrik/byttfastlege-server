require 'sinatra'  
require 'haml'  
require 'json'
require_relative 'fastlege.rb'
require_relative 'setup_database.rb'

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

