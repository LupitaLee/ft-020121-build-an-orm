require "bundler/setup"
Bundler.require

# DB = SQLite3::Database.new('db/twitter.db')
# DB.execute

DB = {:conn => SQLite3::Database.new('db/twitter.db')}
# DB[:conn].execute

DB[:conn].results_as_hash = true

require_all "lib"
require_relative "../db/seeds.rb"