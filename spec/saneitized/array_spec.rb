require 'spec_helper'

describe Saneitized::Array do

  describe '#new' do
    it 'should convert array of numbers' do
      expect(Saneitized::Array.new(['1','2','3'])).to eql [1,2,3]
    end
  end

  describe '#[]=' do
    it 'should convert object at index' do
      a = Saneitized::Array.new
      a[0] = 'true'
      expect(a[0]).to eql true
    end
  end

  describe '#<<' do
    it 'should converted added object' do
      a = Saneitized::Array.new
      a << '11'
      expect(a).to eql [11]
    end
  end
end

