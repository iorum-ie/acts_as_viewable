require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe 'ActsAsViewable' do
  before(:each) do
    ActsAsViewable::Viewing.delete_all
    ActsAsViewable::TotalViewings.delete_all
    @viewable = ViewableModelWithoutTtl.new
  end
  
  describe 'when a ttl is supplied' do
    it 'should define a VIEWING_TIME_TO_LIVE constant in the model to be the supplied value' do
      ViewableModelWithTtl::VIEWING_TIME_TO_LIVE.should == 30
    end
  end
  
  describe 'when no ttl is supplied' do
    it 'should define a VIEWING_TIME_TO_LIVE constant in the model to be 60' do
      ViewableModelWithoutTtl::VIEWING_TIME_TO_LIVE.should == 60
    end
  end
  
  it 'should generate an association for viewings' do
    @viewable.should respond_to(:viewings)
  end
  
  it 'should generate an association for total_viewings' do
    @viewable.should respond_to(:total_viewings)
  end
  
  describe 'most_viewed' do
    before :each do
      @viewable_1 = ViewableModelWithoutTtl.new; @viewable_1.save(:validate => false); @viewable_1.build_total_viewings(:viewings => 1).save(:validate => false)
      @viewable_2 = ViewableModelWithoutTtl.new; @viewable_2.save(:validate => false); @viewable_2.build_total_viewings(:viewings => 2).save(:validate => false)
      @viewable_3 = ViewableModelWithoutTtl.new; @viewable_3.save(:validate => false); @viewable_3.build_total_viewings(:viewings => 3).save(:validate => false)
      @viewable_4 = ViewableModelWithoutTtl.new; @viewable_4.save(:validate => false); @viewable_4.build_total_viewings(:viewings => 4).save(:validate => false)
      @viewable_5 = ViewableModelWithoutTtl.new; @viewable_5.save(:validate => false); @viewable_5.build_total_viewings(:viewings => 5).save(:validate => false)
      @viewable_6 = ViewableModelWithoutTtl.new; @viewable_6.save(:validate => false); @viewable_6.build_total_viewings(:viewings => 6).save(:validate => false)
      @viewable_7 = ViewableModelWithoutTtl.new; @viewable_7.save(:validate => false); @viewable_7.build_total_viewings(:viewings => 7).save(:validate => false)
      @viewable_8 = ViewableModelWithoutTtl.new; @viewable_8.save(:validate => false); @viewable_8.build_total_viewings(:viewings => 8).save(:validate => false)
      @viewable_9 = ViewableModelWithoutTtl.new; @viewable_9.save(:validate => false); @viewable_9.build_total_viewings(:viewings => 9).save(:validate => false)
      @viewable_10 = ViewableModelWithoutTtl.new; @viewable_10.save(:validate => false); @viewable_10.build_total_viewings(:viewings => 10).save(:validate => false)
      @viewable_11 = ViewableModelWithoutTtl.new; @viewable_11.save(:validate => false); @viewable_11.build_total_viewings(:viewings => 11).save(:validate => false)
    end
    
    describe 'when no argument is supplied' do
      it 'should return the 10 viewables with the highest number of total viewings (in descending order)' do
        ViewableModelWithoutTtl.most_viewed.should == [
          @viewable_11, @viewable_10, @viewable_9, @viewable_8, @viewable_7,
          @viewable_6, @viewable_5, @viewable_4, @viewable_3, @viewable_2
        ]
      end
    end
    
    describe 'when an argument is supplied' do
      it 'should return the specified number of viewables with the highest number of total viewings (in descending order)' do
        ViewableModelWithoutTtl.most_viewed(3).should == [@viewable_11, @viewable_10, @viewable_9]
      end
    end
  end
  
  describe 'views' do
    before :each do
      @viewable = ViewableModelWithoutTtl.new; @viewable.save(:validate => false);
    end
    
    describe 'when there is an associated total viewings' do
      before :each do
        @viewable.build_total_viewings(:viewings => 2431267).save(:validate => false)
      end
       
      it 'should return the viewings of the associated total viewings' do
        @viewable.views.should == 2431267
      end
    end
    
    describe 'when there is no associated total viewings' do
      it 'should return 0' do
        @viewable.views.should be_zero
      end
    end
  end
  
  describe 'view!' do
    before :each do
      @ip = 'ip'
      @viewable = ViewableModelWithoutTtl.new; @viewable.save(:validate => false);
      ActsAsViewable::Viewing.stub!(:create).and_return(mock('ActsAsViewable::Viewing', :new_record? => true))
    end
    
    it 'should attempt to create a viewing of the viewable by the supplied IP' do
      ActsAsViewable::Viewing.should_receive(:create).with(:viewable_id => @viewable.id, :viewable_type => 'ViewableModelWithoutTtl', :ip => @ip)
      @viewable.view!(@ip)
    end
    
    describe 'when a viewing of the viewable could be created for the specified IP' do
      before :each do
        ActsAsViewable::Viewing.stub!(:create).and_return(mock('ActsAsViewable::Viewing', :new_record? => false))
      end
      
      describe 'and a total viewings record already exists for this viewable' do
        before :each do
          @total_viewings = mock('ActsAsViewable::TotalViewings', :increment! => true)
          @viewable.stub!(:total_viewings).and_return(@total_viewings)
        end
        
        it 'should increment the number of viewings of the total viewings' do
          @total_viewings.should_receive(:increment!).with(:viewings)
          @viewable.view!(@ip)
        end
      end
      
      describe 'and a total viewings record does not already exist for this viewable' do
        before :each do
          @viewable.stub!(:total_viewings).and_return(nil)
          @viewable.stub!(:create_total_viewings)
        end
        
        it 'should initialise an associated total viewings to a value of 1' do
          @viewable.should_receive(:create_total_viewings).with(:viewable_type => 'ViewableModelWithoutTtl', :viewings => 1)
          @viewable.view!(@ip)
        end
      end
    end
    
    describe 'when a viewing of the viewable could not be created for the specified IP' do
      before :each do
        ActsAsViewable::Viewing.stub!(:create).and_return(mock('ActsAsViewable::Viewing', :new_record? => true))
      end
      
      describe 'and a total viewings record already exists for this viewable' do
        before :each do
          @total_viewings = mock('ActsAsViewable::TotalViewings', :increment! => true)
          @viewable.stub!(:total_viewings).and_return(@total_viewings)
        end
        
        it 'should not increment the number of viewings of the total viewings' do
          @total_viewings.should_not_receive(:increment!)
          @viewable.view!(@ip)
        end
      end
      
      describe 'and a total viewings record does not already exist for this viewable' do
        before :each do
          @viewable.stub!(:total_viewings).and_return(nil)
          @viewable.stub!(:create_total_viewings)
        end
        
        it 'should not initialise an associated total viewings' do
          @total_viewings.should_not_receive(:create_total_viewings)
          @viewable.view!(@ip)
        end
      end
    end
  end
end