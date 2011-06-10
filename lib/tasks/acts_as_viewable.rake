namespace :acts_as_viewable do
  desc 'Delete any Viewing records that are more than the specified number of days old (default 30)'
  task :delete_old_viewing_records, :days_old, :needs => [:environment] do |task, args|
    ActsAsViewable::Viewing.delete_all(['created_at < ?', (args[:days_old] || 30).to_i.days.ago])
  end
end