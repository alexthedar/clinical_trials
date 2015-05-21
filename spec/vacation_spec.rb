require 'spec_helper'

describe(Vacation) do
  it {should belong_to :specialist}
end

describe('#date_range') do
  it('should return the dates between start and end') do
    vacation = Vacation.create({start_date: '2015-01-01', end_date: '2015-01-03', specialist_id: 2})
    expect(vacation.date_range).to(eq(['2015-01-01', '2015-01-02', '2015-01-03']))
  end
end
