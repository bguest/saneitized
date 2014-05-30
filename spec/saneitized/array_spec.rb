require 'spec_helper'

describe Saneitized::Array do

  describe '#new' do
    it 'should convert array of numbers' do
      Saneitized::Array.new(['1','2','3']).should == [1,2,3]
    end
  end

  describe '#[]=' do
    it 'should convert object at index' do
      a = Saneitized::Array.new
      a[0] = 'true'
      a[0].should == true
    end
  end

  describe '#<<' do
    it 'should converted added object' do
      a = Saneitized::Array.new
      a << '11'
      a.should == [11]
    end
  end
end

