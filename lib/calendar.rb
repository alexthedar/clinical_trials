class Calendar
  attr_reader(:start_date, :end_date)

  def initialize(attributes)
    @start_date = attributes[:start_date]
    @end_date   = attributes[:end_date]
  end

  def available_dates
    dates = []
    date = @start_date
    scheduled_visits = Visit.scheduled_visits(@start_date, @end_date)
    until date == @end_date + 1
      scheduled_visits.each do |visit|
        dates << date unless date.weekend? || date.holiday?(:us) || visit.appt_date == date
      end
      date += 1
    end
    dates
  end
end
