class Visit < ActiveRecord::Base
  belongs_to :trial
  belongs_to :patient
  belongs_to :specialist
  belongs_to :schedule
end
