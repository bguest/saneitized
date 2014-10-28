require 'spec_helper'

describe Saneitized do
  describe '#convert' do
    it 'should convert hash' do
      unsullied = {:kick_ass => 'true', :cities_sacked => '3'}
      sanitized = {:kick_ass => true, :cities_sacked => 3}
      expect(Saneitized.convert(unsullied)).to eql sanitized
    end

    it 'should convert array' do
      insane = ['1', '3', '2014-05-29 19:19:44 -0400']
      sane = [1, 3, Time.new(2014,5,29,19,19,44,'-04:00')]
      expect(Saneitized.convert(insane)).to eql sane
    end

    it 'should convert json' do
      insane = {'all' => '34.2', 'base' => ['are', 'true', '10'] }.to_json
      sane = {'all' => 34.2, 'base' => ['are', true, 10]}
      expect(Saneitized.convert(insane)).to eql sane
    end

    %w(nil null NULL).each do | nnil |
      it "should change #{nnil} to nil" do
        expect(Saneitized.convert(nnil)).to be nil
      end
    end

    it "should change 'true' to true" do
      expect(Saneitized.convert('true')).to be true
    end

    it "should change 'false' to false" do
      expect(Saneitized.convert('false')).to be false
    end

    it "should change '12.34' to 12.34" do
      expect(Saneitized.convert('12.34')).to eql 12.34
    end

    it 'should not change 0.5 to 0.0' do
      expect(Saneitized.convert(0.5)).to eql 0.5
    end

    it 'should change integer string to integer' do
      expect(Saneitized.convert('12').kind_of?(Fixnum)).to eql true
    end

    it "should changer '12' to 12" do
      expect(Saneitized.convert('12')).to be 12
    end

    it 'should do nothing to strings' do
      expect(Saneitized.convert('blah')).to eql 'blah'
    end

    it 'should do nothing to nil' do
      expect(Saneitized.convert(nil)).to be nil
    end

    it 'should convert datetime string' do
      expect(Saneitized.convert("2001-02-03 10:11:12 -0400")).to eql Time.new(2001,2,3,10,11,12,'-04:00')
    end

    %w(marketplaces).each do |string|
      it "should leave #{string} alone" do
        expect(Saneitized.convert(string)).to eq string
      end
    end

    context 'with blacklist' do 
      it 'should not convertet blacklisted item' do
        expect(Saneitized.convert('day', blacklist:'day')).to eql 'day'
      end

      it 'should not converter item in blacklist array' do
        expect(Saneitized.convert('day', blacklist:%w(hour day))).to eql 'day'
      end

      it 'should not convert item in hash in blacklist' do
        expected = { 'today' => ['day', 'month', 'week'] }
        expect(Saneitized.convert('{"today":["day","month","week"]}', blacklist:%w(day month week))).to eq expected
      end
    end
  end
end
