class Visit < ActiveRecord::Base
  belongs_to :trial
  belongs_to :patient
  belongs_to :specialist
  has_and_belongs_to_many(:schedules)

end
