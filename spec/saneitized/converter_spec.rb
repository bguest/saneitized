require 'spec_helper'

describe Saneitized do
  describe '#convert' do
    it 'should convert hash' do
      unsullied = {:kick_ass => 'true', :cities_sacked => '3'}
      sanitized = {:kick_ass => true, :cities_sacked => 3}
      Saneitized.convert(unsullied).should == sanitized
    end

    it 'should convert array' do
      insane = ['1', '3', '2014-05-29 19:19:44 -0400']
      sane = [1, 3, Time.new(2014,5,29,19,19,44,'-04:00')]
      Saneitized.convert(insane).should == sane
    end

    it 'should convert json' do
      insane = {'all' => '34.2', 'base' => ['are', 'true', '10'] }.to_json
      sane = {'all' => 34.2, 'base' => ['are', true, 10]}
      Saneitized.convert(insane).should == sane
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

    it 'should convert datetime string' do
      Saneitized.convert("2001-02-03 10:11:12 -0400").should == Time.new(2001,2,3,10,11,12,'-04:00')
    end
  end
end
