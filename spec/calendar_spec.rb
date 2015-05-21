require 'spec_helper'


describe Calendar do
  describe '#start_date' do
    it 'will return the start date' do
      date_0 = Date.new(2015,5,15)
      date_1 = Date.new(2015,5,26)
      cal = Calendar.new(start_date: date_0, end_date: date_1)
      expect(cal.start_date).to eq date_0
    end
  end

  describe '#end_date' do
    it 'will return the end date' do
      date_0 = Date.new(2015,5,15)
      date_1 = Date.new(2015,5,26)
      cal = Calendar.new(start_date: date_0, end_date: date_1)
      expect(cal.end_date).to eq date_1
    end
  end

  describe '#available_dates' do
    it 'will return an array of available dates between a range of dates' do
      cal = Calendar.new(start_date: Date.new(2015,5,15), end_date: Date.new(2015,5,26))
      expect(cal.available_dates).to eq [ Date.new(2015,5,15), Date.new(2015,5,18), Date.new(2015,5,19), Date.new(2015,5,20), Date.new(2015,5,21), Date.new(2015,5,22), Date.new(2015,5,26) ]
    end
  end
end
