require 'spec_helper'

describe Saneitized::Hash do

  describe '#new' do
    it "should change 'true' to true" do
      expect(Saneitized::Hash.new({:true => 'true'})[:true]).to eql true
    end

    it "should change 'false' to false" do
      expect(Saneitized::Hash.new({:false => 'false'})[:false]).to eql false
    end

    it "should change '12.34' to 12.34" do
      expect(Saneitized::Hash.new({value: '12.34'})[:value]).to eql 12.34
    end

    it 'should not change 0.5 to 0.0' do
      expect(Saneitized::Hash.new({value: 0.5})[:value]).to eql 0.5
    end

    it 'should change integer string to integer' do
      expect(Saneitized::Hash.new({int: '12'})[:int].kind_of?(Fixnum)).to be true
    end

    it "should changer '12' to 12" do
      expect(Saneitized::Hash.new({int: '12'})[:int]).to be 12
    end

    it 'should do nothing to strings' do
      expect(Saneitized::Hash.new({string: 'blah'})[:string]).to eql 'blah'
    end

    it 'should do nothing to nil' do
      expect(Saneitized::Hash.new({nill: nil})[:nill]).to be nil
    end
  end

  describe "#[]=" do
    it 'should sanitized assigned keys' do
      hash = Saneitized::Hash.new
      hash['key']= '10'
      expect(hash['key']).to eql 10
    end
  end

end
