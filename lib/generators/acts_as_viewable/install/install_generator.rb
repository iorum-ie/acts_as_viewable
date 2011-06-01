require 'rails/generators/active_record'

module ActsAsViewable
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    def self.source_root
      @_acts_as_viewable_source_root ||= File.expand_path("../templates", __FILE__)
    end

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

    def create_model_file
      migration_template 'acts_as_viewable_migration.rb', "db/migrate/acts_as_viewable_migration.rb"
    end
  end
end
  
  
  