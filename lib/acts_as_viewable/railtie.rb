require 'acts_as_viewable'

module ActsAsViewable
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      initializer 'acts_as_viewable.insert_into_active_record' do
        ActiveSupport.on_load :active_record do
          ActsAsViewable::Railtie.insert
        end
      end
      rake_tasks do
        load "acts_as_viewable.rake", 'lib/tasks/acts_as_viewable.rake', :collision => :ask
      end
    end
  end

  class Railtie
    def self.insert
      ActiveRecord::Base.send :include, ActsAsViewable
    end
  end
end
