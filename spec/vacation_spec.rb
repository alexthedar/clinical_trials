require 'spec_helper'

describe(Vacation) do
  it {should belong_to :specialist}
end

describe('#unavailable_dates') do
  it('should return the dates between start and end') do
    vacation = Vacation.create({start_date: '2015-01-05', end_date: '2015-01-07', specialist_id: 2})
    expect(vacation.unavailable_dates).to(eq([Date.new(2015,01,5),Date.new(2015,01,06),Date.new(2015,01,07)]))
  end
end

describe('.all_vacation_days') do
  it('should return the dates unavailable for a specific specialist') do
    specialist = Specialist.create(first_name: 'John', last_name: 'Digweed', phone: '(404) 281-3895', email: 'john@johndigweed.com')
    vacation = Vacation.create({start_date: '2015-01-12', end_date: '2015-01-14', specialist_id: specialist.id})
    vacation2 = Vacation.create({start_date: '2015-02-04', end_date: '2015-02-06', specialist_id: specialist.id})
    expect(Vacation.all_vacation_days(specialist)).to(eq([Date.new(2015,01,12),Date.new(2015,01,13),Date.new(2015,01,14), Date.new(2015,02,4),Date.new(2015,02,05),Date.new(2015,02,06)]))
  end
end
