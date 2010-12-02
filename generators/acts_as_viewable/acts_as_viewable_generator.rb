module ActsAsViewable
  class ActsAsViewableGenerator < Rails::Generator::Base
    def manifest
      record do |m|
        m.migration_template 'acts_as_viewable_migration.rb', 'db/migrate', :migration_file_name => 'acts_as_viewable_migration'
        m.file 'acts_as_viewable.rake', 'lib/tasks/acts_as_viewable.rake', :collision => :ask
      end
    end
  end
end