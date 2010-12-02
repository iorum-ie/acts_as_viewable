require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

shared_examples_for 'all invalid total viewings' do
  it 'should not be valid' do
    @gig.should_not be_valid
  end
  
  it 'should have an error message' do
    @gig.valid?
    @gig.errors[@attr.to_sym].should_not be_nil
  end
end

describe ActsAsViewable::TotalViewings do
  before(:each) do
    ActsAsViewable::Viewing.delete_all
    ActsAsViewable::TotalViewings.delete_all
  end
  
  def valid_attributes
    {
      :viewable_id => 1,
      :viewable_type => 'viewable type',
      :viewings => 12378
    }
  end
  
  describe 'creation' do
    describe 'with valid arguments' do
      it 'should be valid' do
        ActsAsViewable::TotalViewings.new(valid_attributes).should be_valid
      end
    end
    
    describe 'with invalid arguments' do
      describe '(no viewable_id)' do
        before :each do
          @attr = :viewable_id
          @gig = ActsAsViewable::TotalViewings.new(valid_attributes.except(@attr))
        end
        
        it_should_behave_like 'all invalid total viewings'
      end
    end
    
    describe 'with invalid arguments' do
      describe '(no viewable_type)' do
        before :each do
          @attr = :viewable_type
          @gig = ActsAsViewable::TotalViewings.new(valid_attributes.except(@attr))
        end
        
        it_should_behave_like 'all invalid total viewings'
      end
    end
    
    describe 'with invalid arguments' do
      describe '(no viewings)' do
        before :each do
          @attr = :viewings
          @gig = ActsAsViewable::TotalViewings.new(valid_attributes.except(@attr))
        end
        
        it_should_behave_like 'all invalid total viewings'
      end
    end
  end
end