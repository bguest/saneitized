require 'spec_helper'

describe Saneitized::Hash do

  describe '#new' do
    it "should change 'true' to true" do
      Saneitized::Hash.new({:true => 'true'})[:true].should == true
    end

    it "should change 'false' to false" do
      Saneitized::Hash.new({:false => 'false'})[:false].should == false
    end

    it "should change '12.34' to 12.34" do
      Saneitized::Hash.new({value: '12.34'})[:value].should == 12.34
    end

    it 'should not change 0.5 to 0.0' do
      Saneitized::Hash.new({value: 0.5})[:value].should == 0.5
    end

    it 'should change integer string to integer' do
      Saneitized::Hash.new({int: '12'})[:int].kind_of?(Fixnum).should be_true
    end

    it "should changer '12' to 12" do
      Saneitized::Hash.new({int: '12'})[:int].should == 12
    end

    it 'should do nothing to strings' do
      Saneitized::Hash.new({string: 'blah'})[:string].should == 'blah'
    end

    it 'should do nothing to nil' do
      Saneitized::Hash.new({nill: nil})[:nill].should be_nil
    end
  end

end