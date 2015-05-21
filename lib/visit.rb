class Visit < ActiveRecord::Base
  scope :scheduled_visits, -> (start_date, end_date) {where("appt_date >= ? and appt_date <= ? ", start_date, end_date) }
  belongs_to :trial
  belongs_to :patient
  belongs_to :specialist
  belongs_to :schedule

  def self.scheduled_dates(start_date, end_date)
    dates = []
    scheduled_visits(start_date, end_date).each do |visit|
      dates << visit.appt_date
    end
    dates
  end
end
