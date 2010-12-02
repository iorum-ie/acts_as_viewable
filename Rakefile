require 'rubygems'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = 'acts_as_viewable'
  gem.homepage = 'http://github.com/iorum/acts_as_viewable'
  gem.license = 'MIT'
  gem.summary = %Q{Record IP/timeframe unique viewings of your models}
  gem.description = %Q{Adds models and methods to facilitate tracking of views of your models. Models which act_as_viewable have an instance method view! which will record a viewing of a record by the supplied IP address if and only if the IP has not viewed the record in the last n minutes.}
  gem.email = 'alan@iorum.ie'
  gem.authors = ['Alan Larkin']
  gem.add_development_dependency 'sqlite3-ruby', '>= 1.2.5'
  gem.add_development_dependency 'rspec', '~> 1.3'
  gem.add_development_dependency 'rspec-rails', '~> 1.3'
  gem.add_development_dependency 'timecop'
  gem.add_development_dependency 'jeweler', '~> 1.5.1'
end
Jeweler::RubygemsDotOrgTasks.new

require 'spec/rake/spectask'
desc 'Default: run specs'
task :default => :spec
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "acts_as_viewable #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end