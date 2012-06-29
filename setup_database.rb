require 'data_mapper'
require 'dm-migrations'

if ENV['RACK_ENV'] == 'production' then
	DATABASE_URL = ENV['DATABASE_URL']
else
	APP_ROOT = File.expand_path(File.dirname(__FILE__))
	DATABASE_URL = "sqlite3://#{APP_ROOT}/db/db.sqlite3"
end

DataMapper::setup(:default, "#{DATABASE_URL}")
DataMapper.auto_upgrade!
