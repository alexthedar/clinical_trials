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

  define_singleton_method(:all_vacation_days) do |id|
    all_dates = []
    @specialist = Specialist.find(id)
    @specialist_vacations = @specialist.vacations
     @specialist_vacations.each do |single_vacation|
      dates = single_vacation.unavailable_dates
       dates.each do |single_date|
        all_dates.push(single_date)
      end
    end
  all_dates
  end
end
