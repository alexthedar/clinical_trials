class Patient < ActiveRecord::Base
  has_many :visits
  has_one :schedule, through: :visits
  has_many :specialists, through: :visits
  has_one :trial, through: :visits
end
