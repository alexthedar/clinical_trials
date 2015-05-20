class Schedule < ActiveRecord::Base
  belongs_to(:trial)
  has_many(:visits)
  has_many :patients, through: :visits
  has_many :specialists, through: :visits

end
