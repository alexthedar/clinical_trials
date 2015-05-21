require 'spec_helper'

describe Date do
  describe 'weekend?' do
    it 'will return true if the date is a saturday' do
      date = Date.new(2015,5,9)
      expect(date.weekend?).to eq true
    end

    it 'will retunr true if the date is a sunday' do
      date = Date.new(2015,5,10)
      expect(date.weekend?).to eq true
    end

    it 'will return false of the date is not a weekend day' do
      date = Date.new(2015,5,8)
      expect(date.weekend?).to eq false
    end
  end
end
