module ActsAsViewable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # Options:
    #
    #   :ttl   The minimum number of minutes between viewings of a specific viewable by a specific IP in order for the viewings to be considered distinct
    #
    def acts_as_viewable(options = {})
      include InstanceMethods      
      options = { :ttl => 60 }.merge(options)
      const_set('VIEWING_TIME_TO_LIVE', options[:ttl])
      has_many :viewings, :as => :viewable, :class_name => 'ActsAsViewable::Viewing'
      has_one :total_viewings, :conditions => { :viewable_type => self.name }, :as => :viewable, :class_name => 'ActsAsViewable::TotalViewings'
      named_scope :most_viewed, lambda { |*args| { :include => :total_viewings, :order => '`total_viewings`.`viewings` DESC', :limit => args.first || 10 } }
    end
  end

  module InstanceMethods
    def views
      total_viewings && total_viewings.viewings || 0
    end
    
    def view!(ip)
      unless Viewing.create(:viewable_id => id, :viewable_type => self.class.name, :ip => ip).new_record?
        if total_viewings
          total_viewings.increment!(:viewings)
        else
          create_total_viewings(:viewable_type => self.class.name, :viewings => 1)
        end
      end
    end
  end
end