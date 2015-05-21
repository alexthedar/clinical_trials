class Calendar
  attr_reader(:start_date, :end_date)

  def initialize(attributes)
    @start_date = attributes[:start_date]
    @end_date   = attributes[:end_date]
  end

  def available_dates
    dates = []
    date = @start_date
    until date == @end_date + 1
      dates << date unless date.weekend? || date.holiday?(:us)
      date += 1
    end
    dates
  end
end
