class Patient < ActiveRecord::Base
  has_many :visits

  has_many :specialists, through: :visits
end
