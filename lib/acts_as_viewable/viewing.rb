module ActsAsViewable
  class Viewing < ::ActiveRecord::Base
    belongs_to :viewable, :polymorphic => true
  
    validates_presence_of :viewable_type, :viewable_id, :ip
    validate :ip_has_not_viewed_viewable_in_last_n_minutes, :if => :viewable_type
  
    private
  
    def ip_has_not_viewed_viewable_in_last_n_minutes
      errors.add(:ip, 'has viewed this viewable too recently') unless Viewing.count(:conditions => {
        :ip => ip,
        :viewable_id => viewable_id,
        :viewable_type => viewable_type,
        :created_at => (viewable_type.camelcase.constantize::VIEWING_TIME_TO_LIVE || 0).minutes.ago..Time.now
      }).zero?
    end
  end
end