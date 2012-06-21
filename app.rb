require 'rubygems'  
require 'sinatra'  
require 'haml'  
require 'json'
  
get '/' do  
  haml :index  
end  

get '/fastleger.json' do
  content_type :json
  { :key1 => 'lege1', :key2 => 'blablabla' }.to_json
end
