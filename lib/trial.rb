class Trial < ActiveRecord::Base
  has_and_belongs_to_many :visits
  has_one :schedule
end
