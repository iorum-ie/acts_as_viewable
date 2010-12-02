require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

shared_examples_for 'all invalid viewings' do
  it 'should not be valid' do
    @viewing.should_not be_valid
  end
  
  it 'should have an error message' do
    @viewing.valid?
    @viewing.errors[@attr.to_sym].should_not be_nil
  end
end

describe ActsAsViewable::Viewing do
  before(:each) do
    ActsAsViewable::Viewing.delete_all
    ActsAsViewable::TotalViewings.delete_all
  end
  
  def valid_attributes
    {
      :viewable_type => 'viewable_model_with_ttl',
      :viewable_id => 1,
      :ip => 'ip'
    }
  end
  
  describe 'creation' do
    describe 'with valid arguments' do
      it 'should be valid' do
        ActsAsViewable::Viewing.new(valid_attributes).should be_valid
      end
    end
    
    describe 'with invalid arguments' do
      describe '(no viewable_type)' do
        before :each do
          @attr = :viewable_type
          @viewing = ActsAsViewable::Viewing.new(valid_attributes.except(@attr))
        end
        
        it_should_behave_like 'all invalid viewings'
      end
      
      describe '(no viewable_id)' do
        before :each do
          @attr = :viewable_id
          @viewing = ActsAsViewable::Viewing.new(valid_attributes.except(@attr))
        end
        
        it_should_behave_like 'all invalid viewings'
      end
      
      describe '(no ip)' do
        before :each do
          @attr = :ip
          @viewing = ActsAsViewable::Viewing.new(valid_attributes.except(@attr))
        end
        
        it_should_behave_like 'all invalid viewings'
      end
      
      describe '(it is too soon to create the viewable)' do        
        before :each do
          @attr = :ip
          ActsAsViewable::Viewing.new(valid_attributes.merge(:created_at => 29.minutes.ago)).save(:validate => false)
          @viewing = ActsAsViewable::Viewing.new(valid_attributes)
        end
        
        it_should_behave_like 'all invalid viewings'
      end
    end
  end
end