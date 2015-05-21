class Visit < ActiveRecord::Base
  scope :scheduled_visits, -> (start_date, end_date) {where("appt_date >= ? and appt_date <= ? ", start_date, end_date) }
  belongs_to :trial
  belongs_to :patient
  belongs_to :specialist
  belongs_to :schedule
end
