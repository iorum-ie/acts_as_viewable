$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'acts_as_viewable/viewing'
require 'acts_as_viewable/total_viewings'
require 'acts_as_viewable/acts_as_viewable'

ActiveRecord::Base.class_eval do
  include ActsAsViewable
end

$LOAD_PATH.shift