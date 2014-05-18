require 'spec_helper'

describe Saneitized do
  describe '#convert' do
    it 'should convert hash' do
      unsullied = {:kick_ass => 'true', :cities_sacked => '3'}
      sanitized = {:kick_ass => true, :cities_sacked => 3}
      Saneitized.convert(unsullied).should == sanitized
    end

    it "should change 'true' to true" do
      Saneitized.convert('true').should == true
    end

    it "should change 'false' to false" do
      Saneitized.convert('false').should == false
    end

    it "should change '12.34' to 12.34" do
      Saneitized.convert('12.34').should == 12.34
    end

    it 'should not change 0.5 to 0.0' do
      Saneitized.convert(0.5).should == 0.5
    end

    it 'should change integer string to integer' do
      Saneitized.convert('12').kind_of?(Fixnum).should be_true
    end

    it "should changer '12' to 12" do
      Saneitized.convert('12').should == 12
    end

    it 'should do nothing to strings' do
      Saneitized.convert('blah').should == 'blah'
    end

    it 'should do nothing to nil' do
      Saneitized.convert(nil).should be_nil
    end
  end
end
