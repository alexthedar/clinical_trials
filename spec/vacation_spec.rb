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

describe('#unavailable_dates_for') do
  it('should return the dates unavailable for a specific specialist') do
    specialist = Specialist.create(first_name: 'John', last_name: 'Digweed', phone: '(404) 281-3895', email: 'john@johndigweed.com')
    vacation = Vacation.create({start_date: '2015-01-05', end_date: '2015-01-07', specialist_id: specialist.id})
    vacation2 = Vacation.create({start_date: '2015-02-05', end_date: '2015-02-07', specialist_id: specialist.id})
    all_vacay = specialist.vacations

    expect(specialist.unavailable_dates).to(eq([Date.new(2015,02,5),Date.new(2015,02,06),Date.new(2015,02,07)]))
  end
end
