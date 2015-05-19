class Visit < ActiveRecord::Base
  has_and_belongs_to_many(:trials)
  has_and_belongs_to_many(:specialists)
  has_and_belongs_to_many(:schedules)
  has_and_belongs_to_many(:patients)
end
