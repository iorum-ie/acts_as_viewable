require 'rubygems'
require 'active_record'
require 'spec'

TEST_DATABASE_FILE = File.join(File.dirname(__FILE__), '..', 'test.sqlite3')

File.unlink(TEST_DATABASE_FILE) if File.exist?(TEST_DATABASE_FILE)
ActiveRecord::Base.establish_connection(
  'adapter' => 'sqlite3', 'database' => TEST_DATABASE_FILE
)

load(File.dirname(__FILE__) + '/schema.rb')

$: << File.join(File.dirname(__FILE__), '..', 'lib')
require File.join(File.dirname(__FILE__), '..', 'init')

class ViewableModelWithoutTtl < ActiveRecord::Base
  acts_as_viewable
end

class ViewableModelWithTtl < ActiveRecord::Base
  acts_as_viewable :ttl => 30
end