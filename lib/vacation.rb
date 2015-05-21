class Vacation < ActiveRecord::Base
  belongs_to :specialist


  def unavailable_dates
    vacation_dates = []
    date = self.start_date
    ending_date = self.end_date
    until date == ending_date + 1
      vacation_dates << date unless date.weekend? || date.holiday?(:us)
      date += 1
    end
    vacation_dates
  end
end
