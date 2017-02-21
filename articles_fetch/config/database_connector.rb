require 'active_record'
require 'pg'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'news_world',
  username: 'rpawlas',
  password: '',
  host: 'localhost')
